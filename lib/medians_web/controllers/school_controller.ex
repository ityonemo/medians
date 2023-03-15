defmodule MediansWeb.SchoolController do
  use MediansWeb, :controller

  def index(conn, params(%{"school" => _})) do
    show(conn, params)
  end

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end

  def show(conn, params) do
    render(conn, :show, layout: false)
  end
end
