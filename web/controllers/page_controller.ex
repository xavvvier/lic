defmodule Lic.PageController do
  use Lic.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
