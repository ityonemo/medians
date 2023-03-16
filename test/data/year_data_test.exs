defmodule DataTest.YearDataTest do
  use Medians.DataCase, async: true

  alias Data.Ranks
  alias Data.Schools
  alias Data.YearData

  describe "years statistics" do
    test "works" do
      rank_ids =
        [
          %{year: 2000, rank: 1}
          | for(rank <- 1..3, do: %{year: 1999, rank: rank})
        ]
        |> Ranks.insert!()
        |> Enum.map(& &1.id)

      school_ids =
        for(school <- 1..3, do: %{name: "School #{school}"})
        |> Schools.insert!()
        |> Enum.map(& &1.id)

      # repeat the first school.
      school_ids = [hd(school_ids) | school_ids]

      # create the year statistics
      [rank_ids, school_ids, 1..4]
      |> Enum.zip()
      |> Enum.map(fn {rank_id, school_id, index} ->
        %{rank_id: rank_id, school_id: school_id, L50: index}
      end)
      |> YearData.insert!()

      # we now expect the year 1999 L50 to have a median of 3.
      assert %{min: 2, median: 3, max: 4} == YearData.stats_for(1999, :L50)
    end
  end
end
