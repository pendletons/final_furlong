defmodule Legacy.AccountsTest do
  use Legacy.DataCase
  import Legacy.Factory

  alias Legacy.Accounts
  alias Legacy.Accounts.User

  @update_attrs %{email: "frederick@example.com"}
  @invalid_attrs %{email: nil}

  def user_fixture(attrs \\ params_for(:user)) do
    {:ok, user} = Accounts.create_user(attrs)
    user
  end

  def legacy_user_fixture(attrs \\ params_for(:legacy_user)) do
    {:ok, user} = Accounts.create_legacy_user(attrs)
    user
  end

  def stable_fixture() do
    legacy_user = insert(:legacy_user)
    Accounts.get_stable(legacy_user."ID")
  end

  test "list_users/1 returns all users" do
    user = user_fixture()
    assert Accounts.list_users() == [user]
  end

  test "list_legacy_users/1 returns all users" do
    user = legacy_user_fixture()
    assert Accounts.list_legacy_users() == [user]
  end

  test "get returns the user with given id" do
    user = user_fixture()
    assert Accounts.get(user.id) == user
  end

  test "get by stable returns the stable with the given name" do
    stable = stable_fixture()
    assert Accounts.get_by(%{"StableName" => stable."StableName"}) == stable
  end

  test "create_user/1 with valid data creates a user" do
    user_params = params_for(:user)
    assert {:ok, %User{} = user} = Accounts.create_user(user_params)
    assert user.email == user_params[:email]
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = user_fixture()
    assert {:ok, user} = Accounts.update_user(user, @update_attrs)
    assert %User{} = user
    assert user.email == "frederick@example.com"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = user_fixture()
    assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    assert user == Accounts.get(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = user_fixture()
    assert {:ok, %User{}} = Accounts.delete_user(user)
    refute Accounts.get(user.id)
  end

  test "change_user/1 returns a user changeset" do
    user = user_fixture()
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end

end
