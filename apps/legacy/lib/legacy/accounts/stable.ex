defmodule Legacy.Accounts.Stable do
  @moduledoc """
  Model to store user information
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Legacy.Accounts.Stable

  @primary_key {:ID, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :ID}

  schema "ff_users" do
    field :Email, :string
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
  end

  def changeset(%Stable{} = stable, attrs) do
    stable
    |> cast(attrs, [:StableName, :Description, :TrackId, :TrackMiles])
    |> validate_required([:StableName])
    |> unique_stable
  end

  defp unique_stable(changeset) do
    changeset
    |> validate_length(:StableName, min: 5, max: 20)
    |> unique_constraint(:StableName)
  end

end
