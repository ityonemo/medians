defmodule Db.School do
  use Ecto.Schema

  alias Db.YearData

  schema "schools" do
    field :name, :string
    has_many(:year_data, YearData)

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
