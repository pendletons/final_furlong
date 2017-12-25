defmodule LegacyWeb.StableControllerTest do
  use LegacyWeb.ConnCase

  import Legacy.Factory
  import LegacyWeb.AuthCase

  alias Legacy.{Accounts, Repo}
  alias LegacyWeb.StableView

  setup %{conn: conn} do
    {user, stable} = create_user_and_stable()
    conn = conn |> add_token_conn(user)
    {:ok, %{conn: conn, user: user, stable: stable}}
  end

  def create_user_and_stable(legacy_user_params \\ params_for(:legacy_user)) do
    user = insert(:user)
    legacy_user_params = Ecto.build_assoc(user, :legacy_user, legacy_user_params)
    legacy_user = Repo.insert!(legacy_user_params)
    stable = Accounts.get_stable(legacy_user."ID")
    {user, stable}
  end

  test "GET /stables lists active stables", %{conn: conn, stable: stable} do
    {_user1, active_stable} = create_user_and_stable()
    legacy_params = Map.merge(params_for(:legacy_user), %{Status: "D"})
    {_user2, _inactive_stable} = create_user_and_stable(legacy_params)
    conn = get conn, stable_path(conn, :index)
    assert json_response(conn, 200)["data"] == render_json(StableView, "index.json-api", %{data: [stable, active_stable]})["data"]
  end

  test "GET /stables/:id", %{conn: conn} do
    legacy_user = insert(:legacy_user)
    stable = Accounts.get_stable(legacy_user."ID")
    conn = get conn, stable_path(conn, :show, stable."StableName")
    assert json_response(conn, 200)["data"]
  end

  test "PUT /stables/:id works with own stable", %{conn: conn, stable: stable} do
    update_attrs = %{"Description" => "foo bar"}
    conn = put conn, stable_path(conn, :update, stable), stable: update_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Accounts.get_stable(stable."ID")."Description" == "foo bar"
  end

  test "PUT /stables/:id errors with other stable", %{conn: conn, stable: stable} do
    other_legacy_user = insert(:legacy_user)
    other_stable = Accounts.get_stable(other_legacy_user."ID")
    refute stable == other_stable
    update_attrs = %{"Description" => "foo bar"}
    conn = put conn, stable_path(conn, :update, other_stable), stable: update_attrs
    assert json_response(conn, 401)["error"] =~ "Unauthorized"
    refute Accounts.get_stable(other_stable."ID")."Description" == "foo bar"
  end
end
