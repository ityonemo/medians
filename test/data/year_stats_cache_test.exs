defmodule MediansTest.Data.YearStatsCacheTest do
  use ExUnit.Case, async: true

  alias Data.Sources.YearStatsCache

  describe "insertion and access" do
    @id {990, 1999, :L50}
    @stats %{min: 3, max: 5, median: 4}

    test "works through full lifecyle" do
      assert :error = YearStatsCache.fetch(@id)

      assert :ok = YearStatsCache.store(@id, @stats)

      # make sure we can access from another process
      assert {:ok, @stats} = fn ->
        YearStatsCache.fetch(@id)
      end
      |> Task.async
      |> Task.await
    end
  end
end
