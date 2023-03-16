defmodule Db.Rank do
  use Ecto.Schema

  schema "ranks" do
    field :year, :integer
    field :rank, Db.RankRange
    timestamps()
  end

  import Ecto.Changeset

  def changeset(rank \\ %__MODULE__{}, params) do
    rank
    |> cast(params, [:year, :rank])
    |> validate_required([:year])
  end

  defimpl Phoenix.HTML.Safe do
    # NB: in this code we use high/low verbiage with high meaning a lower integer
    # (this is a 'higher' rank)

    def to_iodata(%{rank: nil}), do: "Unranked"
    def to_iodata(%{rank: rank..rank}), do: "#{rank}"
    def to_iodata(%{rank: high..low}), do: "Tie (#{high}-#{low})"
  end
end
