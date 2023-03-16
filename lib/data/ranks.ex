defmodule Data.Ranks do
  @moduledoc """
  Data layer for the Db.Rank data.

  Contains generalized queries and mutations for Db.Rank data table.

  If any caching or PubSub broadcasting were to occur, this would be placed in this
  module, but we don't have any at this time.
  """

  alias Db.Rank
  import Ecto.Query

  def insert!(year_or_years) do
    year_or_years
    |> List.wrap()
    |> Enum.map(&Db.Repo.insert!(Rank.changeset(&1)))
  end

  def id_by_year_rank(year, rank) when is_binary(rank) do
    # TODO: generalize this with tie_high/tie_low parsing elsewhere in the codebase.
    tie = with {tie_high, "-" <> rest} <- Integer.parse(rank),
         {tie_low, ""} <- Integer.parse(rest),
         true <- tie_high < tie_low do
      {tie_high, tie_low}
    else
      {rank, ""} -> {rank, rank}
      _ -> raise "unusable rank string: #{rank}"
    end
    id_by_year_rank(year, tie)
  end

  def id_by_year_rank(year, {tie_high, tie_low}) do
    Db.Repo.one(from r in Rank, where: r.year == ^year and r.tie_high == ^tie_high and r.tie_low == ^tie_low, select: r.id)
  end

  def all do
    Db.Repo.all(Rank)
  end
end
