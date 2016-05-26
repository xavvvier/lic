defmodule Lic.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :serial_number, :string
      add :description, :text

      timestamps
    end

  end
end
