defmodule Db.Repo.Migrations.ConstrainRankTable do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION btree_gist"
    create unique_index(:ranks, ~w(year tie_low tie_high)a, name: :one_tie_per_year)
    create constraint(:ranks, :tie_low_must_be_positive, check: "tie_low > 0")
    create constraint(:ranks, :no_overlap, exclude: ~s|gist(year WITH =, int4range("tie_low", "tie_high", '[]') WITH &&)|)
  end

  def down do
    drop index(:ranks, [:one_tie_per_year])
    drop constraint(:ranks, [:tie_low_must_be_positive, :no_overlap])
    execute "DROP EXTENSION btree_gist"
  end
end
