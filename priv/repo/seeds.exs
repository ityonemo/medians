# This seed pulls the `data.csv` file and adds it to the database.
#
# There are some nonconformant data, and these data will be cleaned by omission
# before ingress into the normalized database.

defmodule Seeds do
  alias Data.Schools
  alias Data.Ranks

  def insert(row) do
    school_id = ensure_school!(row["School"])
    rank_id = ensure_rank!(row["First Year Class"], row["Rank"])

    row
    |> Map.merge(%{"school_id" => school_id, "rank_id" => rank_id})
    |> Data.YearData.insert!()

  rescue
    error ->
      IO.warn("error inserting row: (#{Exception.message(error)}) #{inspect row}")
  end

  defp ensure_school!(name) do
    if id = Schools.id_by_name(name) do
      id
    else
      %{"name" => name}
      |> Schools.insert!
      |> List.first
      |> Map.get(:id)
    end
  end

  defp ensure_rank!(year, rank) do
    if id = Ranks.id_by_year_rank(year, rank) do
      id
    else
      %{"year" => year, "rank" => rank}
      |> Ranks.insert!
      |> List.first
      |> Map.get(:id)
    end
  end
end


__DIR__
|> Path.join("../seeds/data.csv")
|> Data.Sources.CSV.from_file!
|> Enum.each(&Seeds.insert/1)
