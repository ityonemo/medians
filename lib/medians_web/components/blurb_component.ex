defmodule MediansWeb.BlurbComponent do
  import Phoenix.Template

  embed_templates "blurb/*.html"

  @translation Db.Fields.translation()
  defp translation(field), do: Map.fetch!(@translation, field)

  defp ordinal(%{rank: number..number}) do
    case number do
      number when rem(number, 10) === 1 ->
        "#{number}st"

      number when rem(number, 10) === 2 ->
        "#{number}nd"

      _ ->
        "#{number}th"
    end
  end

  defp ordinal(%{rank: number..other}) do
    other_count = other - number

    case number do
      number when rem(number, 10) === 1 ->
        "Tied for #{number}st with #{other_count} other schools"

      number when rem(number, 10) === 2 ->
        "Tied for #{number}nd with #{other_count} other schools"

      _ ->
        "Tied for #{number}th with #{other_count} other schools"
    end
  end
end
