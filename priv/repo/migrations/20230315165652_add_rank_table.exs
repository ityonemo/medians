defmodule Db.Repo.Migrations.AddRankTable do
  use Ecto.Migration

  def change do
    create table("ranks") do
      add :year, :integer, null: false
      add :tie_low, :integer, null: false
      add :tie_high, :integer, null: false

      timestamps()
    end
  end
end
