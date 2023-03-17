defmodule MediansWeb.SchoolsPageTest do
  use MediansWeb.ConnCase

  alias Data.Schools
  alias Data.Ranks
  alias Data.YearData

  setup do
    [%{id: id}] = Schools.insert!(%{"name" => "Canada College"})

    [%{id: rank_id_1}, %{id: rank_id_2}, %{id: rank_id_3}] =
      Ranks.insert!([
        %{"rank" => 1, "year" => 1999},
        %{"rank" => "2-3", "year" => 2000},
        # unranked for 1998
        %{"year" => 1998}
      ])

    YearData.insert!([
      %{"school_id" => id, "rank_id" => rank_id_1, "L75" => 155, "L50" => 180, "L25" => 205},
      %{"school_id" => id, "rank_id" => rank_id_2, "L75" => 150, "L50" => 175, "L25" => 200},
      %{"school_id" => id, "rank_id" => rank_id_3, "L75" => 150, "L50" => 175, "L25" => 200}
    ])

    {:ok, id: id}
  end

  test "GET /", %{conn: conn, id: id} do
    conn = get(conn, ~p"/schools/#{id}")

    document =
      conn
      |> html_response(200)
      |> Floki.parse_document!()

    assert [
             %{"rank" => "Tie (2-3)", "year" => "2000", "L50" => {"175", ref1}},
             %{"rank" => "1", "year" => "1999", "L50" => {"180", ref2}},
             %{"rank" => "Unranked", "year" => "1998", "L75" => {"150", ref3}}
           ] =
             document
             |> Floki.find("table#schools-table tbody tr")
             |> Enum.map(fn subdocument ->
               subdocument
               |> Floki.find("td")
               |> Enum.zip(["year", "rank", "L75", "L50"])
               |> Map.new(fn
                 {{"td", _, [{"a", [{"href", ref}], [inner_html]}]}, header} ->
                   {header, {String.trim(inner_html), ref}}

                 {{"td", _, [inner_html]}, header} ->
                   {header, inner_html}
               end)
             end)

    assert ref1 == "/schools/#{id}/?year=2000&column=L50"
    assert ref2 == "/schools/#{id}/?year=1999&column=L50"
    assert ref3 == "/schools/#{id}/?year=1998&column=L75"
  end
end
