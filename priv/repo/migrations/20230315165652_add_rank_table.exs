defmodule Db.Repo.Migrations.AddRankTable do
  use Ecto.Migration

  def change do
    create table("ranks") do
      add :year, :integer, null: false
      add :rank, :int4range

      timestamps()
    end
  end
end
