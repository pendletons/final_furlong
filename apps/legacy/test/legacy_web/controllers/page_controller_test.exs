defmodule LegacyWeb.PageControllerTest do
  use LegacyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/legacy"
    assert json_response(conn, 200)["data"] == "Hello World"
  end
end
