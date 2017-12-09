defmodule LegacyWeb.StableController do
  use LegacyWeb, :controller

  alias LegacyWeb.ErrorView

  alias Legacy.{Accounts, Accounts.Stable, Repo}

  def index(conn, params) do
    page = Stable |> Repo.paginate(params)
    render(conn, "index.json-api", %{data: page})
  end

  def show(conn, %{"id" => name}) do
    stable = Accounts.get_by(%{"StableName" => name})
    case Stable.authorize(stable, %{"Admin": false}, :read) do
      {:ok, _} -> render conn, "show.json-api", data: stable
      _ ->
        conn
        |> put_status(:unauthorized)
        |> render(ErrorView, "401.json")
    end
  end

  def update(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"id" => id, "stable" => stable_params}) do
    legacy_user = Repo.one(Ecto.assoc(user, :legacy_user))
    current_stable = Accounts.get_stable(legacy_user."ID")
    stable = Accounts.get_stable(id)
    case Stable.authorize(stable, current_stable, :update) do
      {:ok, _} ->
        with {:ok, stable} <- Accounts.update_stable(current_stable, stable_params) do
          render conn, "show.json-api", data: stable
        end
      _ ->
        conn
        |> put_status(:unauthorized)
        |> render(ErrorView, "401.json")
    end
  end
end
