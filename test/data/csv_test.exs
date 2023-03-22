defmodule MediansTest.Data.CSVTest do
  use ExUnit.Case, async: true

  alias Data.Sources

  @csv_data """
  foo,bar
  1,2
  3,4
  """

  setup do
    path = Path.join(System.tmp_dir!(), ".medians~test~ranking.csv")
    File.write!(path, @csv_data)

    {:ok, path: path}
  end

  test "the ranking module can pull csv data", %{path: path} do
    assert [%{"foo" => "1", "bar" => "2"}, %{"foo" => "3", "bar" => "4"}] ==
             Sources.CSV.from_file!(path)
  end

  @csv_data [%{"foo" => "1", "bar" => "2"}, %{"foo" => "3", "bar" => "4"}]
  test "the frub transform should be the identity for trivial csv" do
    assert @csv_data === Sources.CSV.apply_frub_transform(@csv_data)
  end
end
