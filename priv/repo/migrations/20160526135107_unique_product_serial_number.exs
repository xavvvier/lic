defmodule Lic.Repo.Migrations.UniqueProductSerialNumber do
  use Ecto.Migration

  def change do

    create unique_index(:products, [:serial_number])
  end
end
