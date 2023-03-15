defmodule MediansTest.Data.SchoolsTest do
  use Medians.DataCase, async: true

  alias Data.Schools

  describe "insertion and access" do
    test "works" do
      Schools.insert!([%{"name" => "Canada College"}, %{"name" => "University of the USA"}])
      assert [%{name: "Canada College"}, %{name: "University of the USA"}] = Schools.all(sort: :name)
    end
  end
end
