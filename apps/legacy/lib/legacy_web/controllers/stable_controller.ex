defmodule LegacyWeb.StableController do
  use LegacyWeb, :controller
  use LegacyWeb.Controller

  alias LegacyWeb.ErrorView

  alias Legacy.{Accounts, Accounts.Stable, Repo}

  def index(conn, params, _current_user) do
    page = Accounts.list_stables |> Repo.paginate(params)
    render(conn, "index.json-api", %{data: page})
  end

  def show(conn, %{"id" => name}, _current_user) do
    stable = Accounts.get_by(%{"StableName" => name})
    case Stable.authorize(stable, %{"Admin": false}, :read) do
      {:ok, _} -> render conn, "show.json-api", data: stable
      _ ->
        conn
        |> put_status(:unauthorized)
        |> render(ErrorView, "401.json")
    end
  end

  def update(conn, %{"id" => id, "stable" => stable_params}, current_user) do
    legacy_user = Repo.one(Ecto.assoc(current_user, :legacy_user))
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
