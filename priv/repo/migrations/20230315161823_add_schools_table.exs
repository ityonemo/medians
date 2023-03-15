defmodule Db.Repo.Migrations.AddSchoolsTable do
  use Ecto.Migration

  def change do
    create table("schools") do
      add :name, :string, null: false
      timestamps()
    end
  end
end
