defmodule MediansWeb.MainPageTest do
  use MediansWeb.ConnCase

  alias Data.Schools

  setup do
    Schools.insert!([%{"name" => "Canada College"}, %{"name" => "University of the USA"}])
    :ok
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")

    document =
      conn
      |> html_response(200)
      |> Floki.parse_document!()

    # note that the structure of Floki's parsed html is `{tag, [attribs], [inner_nodes]}`, therefore
    # this should naturally sort by school.id using erlang term order

    schools_list = Floki.find(document, "select#school-select option")

    assert schools_list ===
             (for school <- Schools.all(sort: :id) do
                {"option", [{"value", "#{school.id}"}], [school.name]}
              end)
  end
end
