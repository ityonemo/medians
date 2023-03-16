defmodule Data.YearData do
  @moduledoc """
  Data layer for the Db.YearData data.

  Contains generalized queries and mutations for Db.YearData data table.

  If any PubSub broadcasting were to occur, this would be placed in this
  module, but we don't have any at this time.
  """

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
  def stats_for(year) do
    
  end
end
