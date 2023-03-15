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
        %{"rank" => 2, "year" => 2000}
      ])

    YearData.insert!([
      %{"school_id" => id, "rank_id" => rank_id_1, "L75" => 150, "L50" => 175, "L25" => 200},
      %{"school_id" => id, "rank_id" => rank_id_2, "L75" => 150, "L50" => 175, "L25" => 200}
    ])

    {:ok, id: id}
  end

  test "GET /", %{conn: conn, id: id} do
    conn = get(conn, ~p"/")

    document =
      conn
      |> html_response(200)
      |> Floki.parse_document!()

    years = Floki.find(document, "table#schools-table tr.year-row")

    # school_years = id
    # |> Schools.get
    # |> Db.Repo.preload(:years)
    # |> Map.get(:years)

    years |> dbg(limit: 25)
    # school_years |> dbg(limit: 25)
  end
end
