defmodule LegacyWeb.StableController do
  use LegacyWeb, :controller

  alias Legacy.{Accounts, Repo}

  def index(conn, params) do
    page = Accounts.Stable |> Repo.paginate(params)
    render(conn, "index.json-api", %{data: page})
  end

  def show(conn, %{id: name}) do
    stable = Accounts.get_by(%{"StableName" => name})
    render conn, "show.json-api", data: stable
  end
end
