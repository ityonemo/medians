defmodule MediansWeb.PageController do
  use MediansWeb, :controller

  alias Plug.Conn

  def home(conn, _params) do
    conn
    |> Conn.assign(:schools, Data.Schools.all())
    |> render(:home, layout: false)
  end
end
