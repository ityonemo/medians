defmodule Db.Repo.Migrations.AddYearDataTable do
  use Ecto.Migration

  def change do
    create table("year_data") do
      add :school_id, references(:schools), null: false

      # note that the rank datastructure contains year information
      add :rank_id, references(:ranks), null: false

      add :L75, :integer
      add :L50, :integer
      add :L25, :integer
      add :G75, :decimal
      add :G50, :decimal
      add :G25, :decimal
      add :gre75v, :integer
      add :gre50v, :integer
      add :gre25v, :integer
      add :gre75q, :integer
      add :gre50q, :integer
      add :gre25q, :integer
      add :gre75w, :decimal
      add :gre50w, :decimal
      add :gre25w, :decimal

      timestamps()
    end
  end
end
