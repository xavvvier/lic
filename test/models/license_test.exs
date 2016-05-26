defmodule Lic.LicenseTest do
  use Lic.ModelCase

  alias Lic.License

  @valid_attrs %{description: "some content", number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = License.changeset(%License{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = License.changeset(%License{}, @invalid_attrs)
    refute changeset.valid?
  end
end
