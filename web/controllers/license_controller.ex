defmodule Lic.LicenseController do
  use Lic.Web, :controller

  alias Lic.License
  alias Lic.Product

  plug :scrub_params, "license" when action in [:create, :update]

  def new(conn, %{"product_id" => product_id}) do
    product = Repo.get! Product, product_id
    changeset = License.changeset(%License{product_id: product.id})
    render(conn, "new.html", changeset: changeset, product: product)
  end

  def index(conn, _params) do
    licenses = Repo.all from l in License, preload: [:product]
    render(conn, "index.html", licenses: licenses)
  end

  def create(conn, %{"license" => license_params}) do
    {product_id, ""} = Integer.parse license_params["product_id"]
    changeset = License.changeset(%License{}, license_params)
    changeset = Ecto.Changeset.put_change(changeset, :product_id, product_id)
    case Repo.insert(changeset) do
      {:ok, _license} ->
        conn
        |> put_flash(:info, "License created successfully.")
        |> redirect(to: product_path(conn, :show, product_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    license = Repo.one from l in License,
      preload: [:product], where: l.id == ^id
    changeset = License.changeset(license)
    render(conn, "edit.html", license: license, changeset: changeset)
  end

  def update(conn, %{"id" => id, "license" => license_params}) do
    license = Repo.get!(License, id)
    changeset = License.changeset(license, license_params)

    case Repo.update(changeset) do
      {:ok, license} ->
        conn
        |> put_flash(:info, "License updated successfully.")
        |> redirect(to: product_path(conn, :show, license.product_id))
      {:error, changeset} ->
        render(conn, "edit.html", license: license, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "product" => product}) do
    license = Repo.get!(License, id)

    path = case product do
       "0" -> license_path(conn, :index)
       num -> product_path(conn, :show, String.to_integer(num))
    end
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(license)

    conn
    |> put_flash(:info, "License deleted successfully.")
    |> redirect(to: path)
  end
end
