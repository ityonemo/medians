defmodule MediansWeb.SchoolController do
  use MediansWeb, :controller

  alias Data.Schools
  alias MediansWeb.ChartComponent.Stats
  alias Plug.Conn

  def index(conn, params = %{"id" => _}) do
    show(conn, params)
  end

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end

  def show(conn, %{"id" => id}) do
    school = Schools.get_with_year_data(id)

    conn
    |> Conn.assign(:school, school)
    |> Conn.assign(:stats, Stats.new(school.name, hd(school.year_data), :L50))
    |> render(:show, layout: false)
  end
end
