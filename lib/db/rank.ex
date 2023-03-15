defmodule Db.Rank do
  use Ecto.Schema

  @doc """
  > ### Caution {: .warning}
  >
  > `tie_high` is going to be a lower integer than `tie_low`, as a higher
  > ranked school has a lower integer numerical rank.
  """
  schema "ranks" do
    field :year, :integer
    field :tie_high, :integer
    field :tie_low, :integer
    timestamps()
  end

  import Ecto.Changeset

  def changeset(rank \\ %__MODULE__{}, params) do
    rank
    |> cast(params, [:year])
    |> cast_tie(params)
    |> validate_required([:year, :tie_high, :tie_low])
  end

  defp cast_tie(changeset = %{valid?: false}, _), do: changeset

  defp cast_tie(changeset, %{"rank" => rank}), do: cast_tie(changeset, rank)
  defp cast_tie(changeset, %{rank: rank}), do: cast_tie(changeset, rank)
  defp cast_tie(changeset, rank) when is_integer(rank), do: cast_tie(changeset, {rank, rank})

  defp cast_tie(changeset, rank) when is_binary(rank) do
    with {low, "-" <> rest} <- Integer.parse(rank),
         {high, ""} <- Integer.parse(rest) do
      cast_tie(changeset, {low, high})
    else
      {rank, ""} when is_integer(rank) ->
        cast_tie(changeset, {rank, rank})

      _ ->
        add_error(changeset, :tie_high, "can't correctly parse tie string #{rank}")
    end
  end

  defp cast_tie(changeset, {low, high}) do
    cast(changeset, %{tie_high: low, tie_low: high}, [:tie_high, :tie_low])
  end

  defp cast_tie(changeset, something_else) do
    add_error(
      changeset,
      :tie_high,
      "can't correctly parse rank content #{inspect(something_else)}"
    )
  end

  defimpl Phoenix.HTML.Safe do
    def to_iodata(%{tie_high: rank, tie_low: rank}), do: "#{rank}"
    def to_iodata(%{tie_high: high, tie_low: low}), do: "Tie (#{high}-#{low})"
  end
end
