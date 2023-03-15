defmodule Db.YearData do
  use Ecto.Schema

  schema "year_data" do
    belongs_to :school
    belongs_to :rank

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

  import Ecto.Changeset

  @fields ~w(school_id rank_id L75 L50 L25 G75 G50 G25 gre75v gre50v gre25v gre75q gre50q gre25q gre75w gre50w gre25w)a

  def changeset(rank \\ %__MODULE__{}, params) do
    rank
    |> cast(params, @fields)
    |> validate_required([:school_id, :rank_id])
  end
end
