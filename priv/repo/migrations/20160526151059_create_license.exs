defmodule Lic.Repo.Migrations.CreateLicense do
  use Ecto.Migration

  def change do
    create table(:licenses) do
      add :number, :string
      add :description, :text
      add :product_id, references(:products, on_delete: :nothing)

      timestamps
    end
    create index(:licenses, [:product_id])

  end
end
