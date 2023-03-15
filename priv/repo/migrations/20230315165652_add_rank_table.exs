defmodule Db.Repo.Migrations.AddRankTable do
  use Ecto.Migration

  def change do
    create table("ranks") do
      add :year, :integer
      add :tie_low, :integer
      add :tie_high, :integer

      timestamps()
    end
  end
end
