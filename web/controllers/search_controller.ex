defmodule Lic.SearchController do
  use Lic.Web, :controller

  def create(conn, %{"search" => %{"number" => data}}) do
    render conn, "view.html", result: "Hey: #{data}"
  end
end
