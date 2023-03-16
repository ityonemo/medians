defmodule Data.YearData do
  @moduledoc """
  Data layer for the Db.YearData data.

  Contains generalized queries and mutations for Db.YearData data table.

  If any PubSub broadcasting were to occur, this would be placed in this
  module, but we don't have any at this time.
  """

  alias Data.Sources.YearStatsCache
  alias Db.Rank
  alias Db.YearData
  import Ecto.Query

  def insert!(year_or_years) do
    year_or_years
    |> List.wrap()
    |> Enum.map(&Db.Repo.insert!(YearData.changeset(&1)))
  end

  @doc """
  Since this contains a (possibly expensive) postgres query and is unlikely to
  change, ever, we cache it locally.
  """
  def stats_for(year, column) do
    case YearStatsCache.fetch({year, column}) do
      {:ok, cached} ->
        cached

      :error ->
        column = to_string(column)

        query =
          from y in YearData,
            inner_join: r in Rank,
            on: y.rank_id == r.id and r.year == ^year,
            select: %{
              min: fragment("min(?)", literal(^column)),
              median:
                fragment(
                  ~s|percentile_disc(0.5) WITHIN GROUP (ORDER BY ?.?)|,
                  y,
                  literal(^column)
                ),
              max: fragment("max(?)", literal(^column))
            }

        result = Db.Repo.one(query)

        YearStatsCache.store({year, column}, result)
    end
  end
end
