defmodule MediansWeb.SchoolController do
  use MediansWeb, :controller

  alias Data.Schools
  alias MediansWeb.ChartComponent.Stats
  alias Plug.Conn

  def index(conn, params = %{"id" => _}) do
    show(conn, params)
  end

  def index(conn, params) do
    # TODO: make this a true index page instead of just going to the first item.
    show(conn, Map.put(params, "id", 1))
    # render(conn, :index)
  end

  def show(conn, params = %{"id" => id}) do
    school = Schools.get_with_year_data(id)

    year_data = year_data_for(params["year"], school.year_data)
    column = column_for(params["column"])

    conn
    |> Conn.assign(:school, school)
    |> Conn.assign(:stats, Stats.new(school.name, year_data, column))
    |> Conn.assign(:column, column)
    |> Conn.assign(:year_data, year_data)
    |> render(:show)
  end

  defp year_data_for(nil, year_data), do: hd(year_data)

  defp year_data_for(year_str, year_data) do
    case Integer.parse(year_str) do
      {number, ""} ->
        Enum.find(year_data, hd(year_data), &(&1.rank.year === number))

      _ ->
        hd(year_data)
    end
  end

  @stat_assignments Map.new(
                      ~w(L75 L50 L25 G75 G50 G25 gre75v gre50v gre25v gre75q gre50q gre25q gre75w gre50w gre25w)a,
                      fn atom -> {Atom.to_string(atom), atom} end
                    )

  defp column_for(column_string), do: Map.get(@stat_assignments, column_string, :L50)
end
