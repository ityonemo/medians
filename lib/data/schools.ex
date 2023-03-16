defmodule Data.Schools do
  @moduledoc """
  Data layer for the Db.School data.

  Contains generalized queries and mutations for Db.School data table.


  If any caching or PubSub broadcasting were to occur, this would be placed in this
  module, but we don't have any at this time.
  """

  alias Db.Rank
  alias Db.School
  alias Db.YearData
  import Ecto.Query

  def all(opts \\ []) do
    query =
      if sort_key = opts[:sort] do
        from s in School, order_by: ^sort_key
      else
        School
      end

    Db.Repo.all(query)
  end

  def get_with_year_data(id) do
    # NB: this accessor needs to do a complicated SQL query to ensure that the
    # year information is ordered correctly. instead of doing a preload, we
    # have to perform the join manually and then stitch the resulting struct
    # together by substituting the rank result into the rank field directly

    ordered_years =
      from(y in YearData,
        join: r in Rank,
        on: r.id == y.rank_id,
        order_by: [desc: r.year],
        select: %{y | rank: r}
      )

    query = from s in School, where: s.id == ^id, select: s, preload: [year_data: ^ordered_years]

    Db.Repo.one(query)
  end

  def id_by_name(name) do
    Db.Repo.one(from s in School, where: s.name == ^name, select: s.id)
  end

  def insert!(school_or_schools) do
    school_or_schools
    |> List.wrap()
    |> Enum.map(&Db.Repo.insert!(School.changeset(&1)))
  end
end
