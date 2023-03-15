defmodule Db.Rank do
  use Ecto.Schema

  schema "ranks" do
    field :year, :integer
    field :tie_low, :integer
    field :tie_high, :integer
    timestamps()
  end

  import Ecto.Changeset

  def changeset(rank \\ %__MODULE__{}, params) do
    rank
    |> cast(params, [:year, :tie_low, :tie_high])
    |> validate_required([:name, :tie_low, :tie_high])
  end
end
