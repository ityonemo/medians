defmodule MediansWeb.PageController do
  use MediansWeb, :controller

  alias Plug.Conn

  alias Data.Schools

  def home(conn, _params) do
    conn
    |> Conn.assign(:schools, Schools.all())
    |> render(:home, layout: false)
  end
end
