defmodule MediansWeb.SchoolController do
  use MediansWeb, :controller

  def index(conn, params) do
    if params["school"] do
      show(conn, params)
    else
      render(conn, :index, layout: false)
    end
  end

  def show(conn, params) do
    render(conn, :show, layout: false)
  end
end
