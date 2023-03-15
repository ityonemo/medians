defmodule Db.YearData do
  use Ecto.Schema

  schema "year_data" do
    belongs_to(:school, Db.School)
    belongs_to(:rank, Db.Rank)

    field :L75, :integer
    field :L50, :integer
    field :L25, :integer
    field :G75, :decimal
    field :G50, :decimal
    field :G25, :decimal
    field :gre75v, :integer
    field :gre50v, :integer
    field :gre25v, :integer
    field :gre75q, :integer
    field :gre50q, :integer
    field :gre25q, :integer
    field :gre75w, :decimal
    field :gre50w, :decimal
    field :gre25w, :decimal

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
