defmodule MediansWeb.SchoolController do
  use MediansWeb, :controller

  alias Data.Schools
  alias Plug.Conn

  def index(conn, params = %{"id" => _}) do
    show(conn, params)
  end

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end

  def show(conn, %{"id" => id}) do
    conn
    |> Conn.assign(:school, Schools.get_with_year_data(id))
    |> render(:show, layout: false)
  end
end
