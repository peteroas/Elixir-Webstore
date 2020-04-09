defmodule Store.Repo.Migrations.CreateVariants do
  use Ecto.Migration

  def change do
    create table(:variants) do
      add :price, :integer
      add :size, :string
      add :color, :string

      timestamps()
    end

  end
end
