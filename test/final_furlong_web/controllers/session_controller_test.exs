defmodule FinalFurlongWeb.SessionControllerTest do
  use FinalFurlongWeb.ConnCase

  import FinalFurlong.Factory
  import FinalFurlongWeb.AuthCase

  @confirmed_attrs params_for(:user, password: "reallyHard2gue$$")
  @invalid_attrs params_for(:user)
  @unconfirmed_attrs params_for(:user, password: "reallyHard2gue$$")

  setup %{conn: conn} do
    add_user(@unconfirmed_attrs[:email])
    user = add_user_confirmed(@confirmed_attrs[:email])
    {:ok, %{conn: conn, user: user}}
  end

  test "login succeeds", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @confirmed_attrs
    assert json_response(conn, 200)["access_token"]
  end

  test "login fails for user that is not yet confirmed", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @unconfirmed_attrs
    assert json_response(conn, 401)["errors"]["detail"] =~ "need to login"
  end

  test "login fails for user that is already logged in", %{conn: conn, user: user} do
    conn = conn |> add_token_conn(user)
    conn = post conn, session_path(conn, :create), session: @confirmed_attrs
    assert json_response(conn, 401)["errors"]["detail"] =~ "already logged in"
  end

  test "login fails for invalid password", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs
    assert json_response(conn, 401)["errors"]["detail"] =~ "need to login"
  end
end
