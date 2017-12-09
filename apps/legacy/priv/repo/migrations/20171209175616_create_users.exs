defmodule Legacy.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :sessions, {:map, :integer}
      add :legacy_user_id, references(:ff_users, type: :integer, column: "ID", on_delete: :nothing)

      timestamps()
    end

    alter table(:ff_users) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create unique_index :users, [:email]
    create unique_index :users, [:legacy_user_id]
  end
end
