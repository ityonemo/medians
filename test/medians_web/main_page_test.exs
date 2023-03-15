defmodule MediansWeb.MainPageTest do
  use MediansWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")

    document =
      conn
      |> html_response(200)
      |> Floki.parse_document!()

    assert {"option", [], ["Yale University"]} in Floki.find(
             document,
             "select#school-select option"
           )
  end
end
