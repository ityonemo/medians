defmodule DataTest.RanksTest do
  use Medians.DataCase, async: true

  alias Data.Ranks

  describe "ranks can be inserted" do
    test "with a single number" do
      Ranks.insert!(%{"year" => 1999, "rank" => 1})

      assert [%{year: 1999, rank: 1..1}] = Ranks.all()
    end

    test "with a number string" do
      Ranks.insert!(%{"year" => 1999, "rank" => "1"})

      assert [%{year: 1999, rank: 1..1}] = Ranks.all()
    end

    test "with a range string" do
      Ranks.insert!(%{"year" => 1999, "rank" => "1-4"})

      assert [%{year: 1999, rank: 1..4}] = Ranks.all()
    end

    test "as unranked" do
      Ranks.insert!(%{"year" => 1999})

      assert [%{year: 1999, rank: nil}] = Ranks.all()
    end

    test "with same rank, different year" do
      Ranks.insert!([%{"year" => 1999, "rank" => "1"}, %{"year" => 1998, "rank" => "1"}])

      assert [%{year: 1999, rank: 1..1}, %{year: 1998, rank: 1..1}] = Ranks.all()
    end

    test "with overlapping ranks, different year" do
      Ranks.insert!([%{"year" => 1999, "rank" => "1-5"}, %{"year" => 1998, "rank" => "2-6"}])

      assert [%{year: 1999, rank: 1..5}, %{year: 1998, rank: 2..6}] = Ranks.all()
    end
  end

  describe "you can't add two ranks when" do
    test "same year, same number" do
      assert_raise Ecto.ConstraintError, fn ->
        Ranks.insert!([%{"year" => 1999, "rank" => 1}, %{"year" => 1999, "rank" => 1}])
      end
    end

    test "same year, overlapping ranges" do
      assert_raise Ecto.ConstraintError, fn ->
        Ranks.insert!([%{"year" => 1999, "rank" => 1}, %{"year" => 1999, "rank" => "1-5"}])
      end
    end
  end
end
