defmodule Lic.Product do
  use Lic.Web, :model

  schema "products" do
    field :serial_number, :string
    field :description, :string
    has_many :licenses, Lic.License
    timestamps
  end

  @required_fields ~w(serial_number)
  @optional_fields ~w(description)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:serial_number)
  end
end
