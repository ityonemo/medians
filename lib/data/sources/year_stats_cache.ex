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
    {:ok, [], :hibernate}
  end

  use MatchSpec

  defmatchspecp fetch_spec(school_id, year, row) do
    {{^school_id, ^year, ^row}, stats} -> stats
  end

  def store(tag = {_school_id, _year, _row}, stats = %{max: _, min: _, median: _}) do
    :ets.insert(__MODULE__, {tag, stats})
    :ok
  end

  @spec fetch({term, integer, atom}) :: %{max: term, min: term, median: term}
  def fetch({school_id, year, row}) do
    case :ets.select(__MODULE__, fetch_spec(school_id, year, row)) do
      [] -> :error
      [stats] -> {:ok, stats}
    end
  end
end
