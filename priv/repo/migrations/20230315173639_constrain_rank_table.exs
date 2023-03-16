defmodule Db.Repo.Migrations.ConstrainRankTable do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION btree_gist"
    create unique_index(:ranks, ~w(year rank)a, name: :one_rank_per_year)
    create constraint(:ranks, :tie_high_must_be_positive, check: "upper(rank) > 0")

    create constraint(:ranks, :no_overlap,
             exclude: ~s|gist(year WITH =, rank WITH &&)|
           )
  end

  def down do
    drop index(:ranks, [:one_rank_per_year])
    drop constraint(:ranks, [:tie_high_must_be_positive, :no_overlap])
    execute "DROP EXTENSION btree_gist"
  end
end
