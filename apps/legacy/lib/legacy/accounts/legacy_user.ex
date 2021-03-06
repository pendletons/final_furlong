defmodule Legacy.Accounts.LegacyUser do
  @moduledoc """
  Model to store user information
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Legacy.Accounts.{LegacyUser, User}

  @primary_key {:ID, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :ID}

  schema "ff_users" do
    field :Username, :string
    field :Status, :string
    field :Admin, :boolean, default: false
    field :Name, :string
    field :ForumID, :integer
    field :Email, :string
    field :StableName, :string
    field :Description, :string
    field :JoinDate, :date
    field :LastLogin, :utc_datetime
    field :PrevLogin, :utc_datetime
    field :IP, :string
    field :Emailed, :boolean, default: false
    field :EmailVal, :boolean, default: false
    field :Approval, :boolean, default: false
    field :Birthday, :string
    field :Birthyear, :string
    field :last_modified, :utc_datetime
    field :slug, :string
    belongs_to :user, User
  end

  def changeset(%LegacyUser{} = user, attrs) do
    user
    |> cast(attrs, [:Email])
    |> validate_required([:Email])
    |> unique_email
  end

  def admin_changeset(%LegacyUser{} = user, attrs) do
    user
    |> cast(attrs, [:Email, :Admin])
    |> validate_required([:Email])
    |> unique_email
  end

  defp unique_email(changeset) do
    changeset
    |> validate_format(:Email, ~r/@/)
    |> validate_length(:Email, min: 5, max: 254)
    |> unique_constraint(:Email)
  end

end
