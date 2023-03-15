defmodule MediansWeb.MainPageTest do
  use MediansWeb.ConnCase

  alias Data.Schools

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")

    document =
      conn
      |> html_response(200)
      |> Floki.parse_document!()

    schools_list = Floki.find(document,"select#school-select option")

    Enum.each(Schools.all(), fn school ->
      assert {"option", [{"value", "#{school.id}"}], [school.name]} in schools_list
    end)
  end
end
