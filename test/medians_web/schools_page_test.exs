defmodule MediansWeb.SchoolsPageTest do
  use MediansWeb.ConnCase

  alias Data.Schools
  alias Data.Years

  setup do
    [%{id: id}] = Schools.insert!(%{"name" => "Canada College"})

    Years.insert!([
      %{"school_id" => id, "rank" => 1, "year" => 1999, "L75" => 150, "L50" => 175, "L25" => 200},
      %{"school_id" => id, "rank" => 2, "year" => 2000, "L75" => 150, "L50" => 175, "L25" => 200}
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
