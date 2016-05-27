defmodule Lic.SearchController do
  use Lic.Web, :controller
  alias Lic.Repo
  alias Lic.License

  def create(conn, %{"search" => %{"number" => data}}) do
    licenses = Repo.all from l in License,
      join: p in assoc(l, :product),
      where: p.serial_number == ^data,
      select: [l.number, l.description]
    render conn, "view.html", result: licenses
  end
end
