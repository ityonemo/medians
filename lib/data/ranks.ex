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

  def all do
    Db.Repo.all(Rank)
  end
end
