defmodule Legacy.Accounts.Stable do
  @moduledoc """
  Model to store user information
  """
  use Ecto.Schema
  use Authorize.Inline

  import Ecto.Changeset

  alias Legacy.Accounts.Stable

  @primary_key {:ID, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :ID}

  schema "ff_users" do
    field :Username, :string
    field :Email, :string
    field :Status, :string
    field :Admin, :boolean, default: false
    field :Name, :string
    field :StableName, :string
    field :Description, :string
    field :TrackId, :integer
    field :TrackMiles, :integer
    field :LastEntry, :utc_datetime
    field :LastBought, :utc_datetime
    field :LastSold, :utc_datetime
    field :LastStudBred, :utc_datetime
    field :LastMareBred, :utc_datetime
    field :CreateAuction, :integer, default: 1
    field :Cheating, :boolean, default: false
    field :last_modified, :utc_datetime
    field :slug, :string
  end

  def changeset(%Stable{} = stable, attrs) do
    stable
    |> cast(attrs, [:StableName, :Description, :TrackId, :TrackMiles])
    |> validate_required([:StableName])
    |> unique_stable
  end

  authorize do
    rule "authorize admins for everything", _, actor do
      if actor."Admin", do: :ok, else: :undecided
    end

    rule :update, "users can update their own stables", struct_or_changeset, actor do
      stable = get_struct(struct_or_changeset)
      if actor."ID" == stable."ID", do: :ok, else: :unauthorized
    end

    rule :read, "everyone can read stables", _, _ do
      :ok
    end

    rule :create, "users cannot create stables", _, _actor do
      :unauthorized
    end
  end

  defp unique_stable(changeset) do
    changeset
    |> validate_length(:StableName, min: 5, max: 20)
    |> unique_constraint(:StableName)
  end

end
