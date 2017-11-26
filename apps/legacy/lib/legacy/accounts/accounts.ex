defmodule Legacy.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Legacy.Accounts.{User, Stable}
  alias Legacy.Repo

  def list_users do
    Repo.all(User)
  end

  def get(id), do: Repo.get(User, id)

  def get_by(%{"Email" => email}) do
    Repo.get_by(User, Email: email)
  end

  def get_by(%{"StableName" => name}) do
    Repo.get_by(Stable, StableName: name)
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def list_stables do
    Repo.all(Stable)
  end

  def create_stable(attrs) do
    %Stable{}
    |> Stable.changeset(attrs)
    |> Repo.insert
  end

  def update_stable(%Stable{} = stable, attrs) do
    stable
    |> Stable.changeset(attrs)
    |> Repo.update
  end

  def delete_stable(%Stable{} = stable) do
    Repo.delete(stable)
  end

  def change_stable(%Stable{} = stable) do
    Stable.changeset(stable, %{})
  end
end
