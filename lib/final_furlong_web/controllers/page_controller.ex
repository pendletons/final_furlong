defmodule FinalFurlongWeb.PageController do
  use FinalFurlongWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
