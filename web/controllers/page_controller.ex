defmodule SimpleBoard.PageController do
  use SimpleBoard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
