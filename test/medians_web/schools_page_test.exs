defmodule MediansWeb.SchoolsPageTest do
  use MediansWeb.ConnCase

  alias Data.Schools
  alias Data.Ranks
  alias Data.YearData

  setup do
    [%{id: id}] = Schools.insert!(%{"name" => "Canada College"})

    [%{id: rank_id_1}, %{id: rank_id_2}] =
      Ranks.insert!([
        %{"rank" => 1, "year" => 1999},
        %{"rank" => "2-3", "year" => 2000}
      ])

    YearData.insert!([
      %{"school_id" => id, "rank_id" => rank_id_1, "L75" => 155, "L50" => 180, "L25" => 205},
      %{"school_id" => id, "rank_id" => rank_id_2, "L75" => 150, "L50" => 175, "L25" => 200}
    ])

    {:ok, id: id}
  end

  test "GET /", %{conn: conn, id: id} do
    conn = get(conn, ~p"/schools/#{id}")

    document =
      conn
      |> html_response(200)
      |> Floki.parse_document!()

    headers =
      document
      |> Floki.find("table#schools-table th")
      |> Enum.map(fn {"th", _, [header]} -> header end)

    assert [
      %{"rank" => "Tie (2-3)", "year" => "2000", "L50" => "175"},
      %{"rank" => "1", "year" => "1999", "L50" => "180"}
    ] =
      document
      |> Floki.find("table#schools-table tbody tr")
      |> Enum.map(fn subdocument ->
        subdocument
        |> Floki.find("td")
        |> Enum.zip(headers)
        |> Map.new(fn {{"td", _, inner_html}, header} -> {header, List.first(inner_html)} end)
      end)
  end
end
