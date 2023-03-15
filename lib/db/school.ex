defmodule Db.School do
  use Ecto.Schema

  schema "schools" do
    field :name, :string
    timestamps()
  end

  import Ecto.Changeset

  def changeset(school \\ %__MODULE__{}, params) do
    school
    |> cast(params, [:name])
    |> validate_required(:name)
    |> unique_constraint([:name])
  end
end
