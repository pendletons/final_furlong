defmodule LegacyWeb.PageController do
  use LegacyWeb, :controller

  def index(conn, _) do
    render(conn, "index.json")
  end
end
