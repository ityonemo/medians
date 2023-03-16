defmodule Data.Sources.YearStatsCache do
  @moduledoc """
  in-memory cache module for YearData information.

  Makes it so that we don't have to take as many trips to the database
  to obtain aggregate data on rows.
  """

  use GenServer

  # creates a singleton for the year stats
  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_) do
    :ets.new(__MODULE__, [:public, :named_table])
    # this process exists solely to own the ets table, it should never
    # receive messages so we can hibernate forever and the BEAM will basically
    # forget that it exists when prioritizing processes
    {:ok, [], :hibernate}
  end

  use MatchSpec

  defmatchspecp fetch_spec(year, row) do
    {{^year, ^row}, stats} -> stats
  end

  def store(tag = {_year, _row}, stats = %{max: _, min: _, median: _}) do
    :ets.insert(__MODULE__, {tag, stats})
    stats
  end

  @spec fetch({integer, atom}) :: %{max: term, min: term, median: term}
  def fetch({year, row}) do
    case :ets.select(__MODULE__, fetch_spec(year, row)) do
      [] -> :error
      [stats] -> {:ok, stats}
    end
  end
end
