defmodule Legacy.StablesTest do
  use Legacy.DataCase

  import Legacy.Factory

  alias Legacy.Accounts
  alias Legacy.Accounts.Stable

  test "inline authorization" do
    stable = stable()
    other_stable = stable()
    assert {:ok, _, "authorize admins for everything"} = Stable.authorize(stable, admin_user(), :create, include_reason: true)
    assert {:unauthorized, _, "users cannot create stables"} = Stable.authorize(stable, other_stable, :create)

    assert {:ok, _, "users can update their own stables"} = Stable.authorize(stable, stable, :update, include_reason: true)
    assert {:unauthorized, _, "users can update their own stables"} = Stable.authorize(stable, other_stable, :update)

    assert {:ok, _, "everyone can read stables"} = Stable.authorize(stable, other_stable, :read, include_reason: true)
  end

  defp stable do
    insert(:stable)
  end

  defp admin_user do
    user_params = :user |> params_for |> make_admin
    {:ok, user} = Accounts.admin_create_user(user_params)
    user
  end
end
