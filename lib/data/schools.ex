defmodule Data.Schools do
  @moduledoc """
  Data layer for the Db.School data.

  Contains generalized queries and mutations for Db.School data table.


  If any caching or PubSub broadcasting were to occur, this would be placed in this
  module, but we don't have any at this time.
  """

  alias Db.School
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

  def insert!(school_or_schools) do
    school_or_schools
    |> List.wrap()
    |> Enum.map(&Db.Repo.insert!(School.changeset(&1)))
  end
end
