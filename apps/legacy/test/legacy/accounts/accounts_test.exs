defmodule Legacy.AccountsTest do
  use Legacy.DataCase

  import Legacy.Factory

  alias Legacy.Accounts
  alias Legacy.Accounts.User

  @invalid_attrs %{Email: nil}

  def user_fixture(attrs \\ params_for(:user)) do
    {:ok, user} = Accounts.create_user(attrs)
    user
  end

  def stable_fixture(attrs \\ params_for(:stable)) do
    {:ok, stable} = Accounts.create_stable(attrs)
    stable
  end

  test "list_users/1 returns all users" do
    user = user_fixture()
    assert Accounts.list_users() == [user]
  end

  test "get returns the user with given id" do
    user = user_fixture()
    assert Accounts.get(user."ID") == user
  end

  test "get by email returns the user with given address" do
    user = user_fixture()
    assert Accounts.get_by(%{"Email" => user."Email"}) == user
  end

  test "get by stable returns the user with given name" do
    stable = stable_fixture()
    assert Accounts.get_by(%{"StableName" => stable."StableName"}) == stable
  end

  test "create_user/1 with valid data creates a user" do
    attrs = params_for(:user)
    assert {:ok, %User{} = user} = Accounts.create_user(attrs)
    assert user."Email" == attrs[:Email]
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = user_fixture()
    update_attrs = params_for(:user)
    assert {:ok, user} = Accounts.update_user(user, update_attrs)
    assert %User{} = user
    assert user."Email" == update_attrs[:Email]
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = user_fixture()
    assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    assert user == Accounts.get(user."ID")
  end

  test "delete_user/1 deletes the user" do
    user = user_fixture()
    assert {:ok, %User{}} = Accounts.delete_user(user)
    refute Accounts.get(user."ID")
  end

  test "change_user/1 returns a user changeset" do
    user = user_fixture()
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end

end
