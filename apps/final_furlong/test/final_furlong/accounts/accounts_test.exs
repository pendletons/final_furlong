defmodule FinalFurlong.AccountsTest do
  use FinalFurlong.DataCase

  import FinalFurlong.Factory

  alias FinalFurlong.Accounts
  alias FinalFurlong.Accounts.User

  @invalid_attrs %{email: nil}

  def fixture(:user, attrs \\ params_for(:user)) do
    {:ok, user} = Accounts.create_user(attrs)
    user
  end

  test "list_users/1 returns all users" do
    user = fixture(:user)
    assert Accounts.list_users() == [user]
  end

  test "get returns the user with given id" do
    user = fixture(:user)
    assert Accounts.get(user.id) == user
  end

  test "create_user/1 with valid data creates a user" do
    attrs = params_for(:user)
    assert {:ok, %User{} = user} = Accounts.create_user(attrs)
    assert user.email == attrs[:email]
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = fixture(:user)
    update_attrs = %{params_for(:user) | password: nil}
    assert {:ok, user} = Accounts.update_user(user, update_attrs)
    assert %User{} = user
    assert user.email == update_attrs[:email]
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture(:user)
    assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    assert user == Accounts.get(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = fixture(:user)
    assert {:ok, %User{}} = Accounts.delete_user(user)
    refute Accounts.get(user.id)
  end

  test "change_user/1 returns a user changeset" do
    user = fixture(:user)
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end

  test "update password changes the stored hash" do
    %{password_hash: stored_hash} = user = fixture(:user)
    attrs = %{password: "CN8W6kpb"}
    {:ok, %{password_hash: hash}} = Accounts.update_password(user, attrs)
    assert hash != stored_hash
  end

  test "update_password with weak password fails" do
    user = fixture(:user)
    attrs = %{password: "pass"}
    assert {:error, %Ecto.Changeset{}} = Accounts.update_password(user, attrs)
  end

end
