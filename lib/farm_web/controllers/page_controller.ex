defmodule FarmWeb.PageController do
  use FarmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
