defmodule Legacy.Repo.Migrations.CreateFfUsers do
  use Ecto.Migration

  def change do
    create table("ff_users", primary_key: false) do
      add :ID, :"INT AUTO_INCREMENT primary key NOT NULL", prmary_key: true
      add :Username, :string
      add :Password, :string
      add :Status, :string, size: 3
      add :Admin, :boolean, default: false
      add :StableName, :string
      add :Name, :string
      add :ForumID, :integer
      add :BugID, :integer
      add :Email, :string
      add :TrackId, :integer
      add :TrackMiles, :integer
      add :RefID, :integer
      add :Flag, :integer
      add :LastLogin, :utc_datetime
      add :PrevLogin, :utc_datetime
      add :LastEntry, :utc_datetime
      add :LastBought, :utc_datetime
      add :LastSold, :utc_datetime
      add :LastStudBred, :utc_datetime
      add :LastMareBred, :utc_datetime
      add :JoinDate, :date
      add :IP, :string
      add :FlagDate, :date
      add :Emailed, :boolean, default: false
      add :EmailVal, :boolean, default: false
      add :Approval, :boolean, default: false
      add :Description, :longtext
      add :Birthday, :string
      add :Birthyear, :string
      add :Level, :integer, size: 2
      add :Cheating, :boolean, default: false
      add :Timestamp, :utc_datetime
      add :CreateAuction, :boolean, default: true
      add :last_modified, :utc_datetime
      add :slug, :string
      add :user_id, :integer
    end
  end
end
