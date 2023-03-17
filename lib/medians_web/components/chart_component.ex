defmodule MediansWeb.ChartComponent do
  import Phoenix.Template

  embed_templates "chart/*.svg"

  alias Data.YearData

  defmodule Stats do
    @enforce_keys [
      :low_norm,
      :low_value,
      :median_norm,
      :median_value,
      :high_norm,
      :high_value,
      :school_norm,
      :school_value,
      :min,
      :max,
      :stat,
      :school_name
    ]
    defstruct @enforce_keys

    @lsat_range {120, 180}
    @gpa_range {0.0, 5.0}
    @gre_range {130, 170}
    @grew_range {0.0, 6.0}

    @stat_range %{
      L25: @lsat_range,
      L50: @lsat_range,
      L75: @lsat_range,
      G25: @gpa_range,
      G50: @gpa_range,
      G75: @gpa_range,
      gre25v: @gre_range,
      gre50v: @gre_range,
      gre75v: @gre_range,
      gre25q: @gre_range,
      gre50q: @gre_range,
      gre75q: @gre_range,
      gre25w: @grew_range,
      gre50w: @grew_range,
      gre75w: @grew_range
    }

    @translation Db.Fields.translation()

    def new(school_name, yeardata, column) do
      school_stat = Map.fetch!(yeardata, column)
      year_stats = YearData.stats_for(yeardata.rank.year, column)
      range = {stat_min, stat_max} = Map.fetch!(@stat_range, column)

      %__MODULE__{
        school_name: school_name,
        school_value: school_stat,
        school_norm: normalize(school_stat, range),
        low_norm: normalize(year_stats.min, range),
        low_value: year_stats.min,
        high_norm: normalize(year_stats.max, range),
        high_value: year_stats.max,
        median_norm: normalize(year_stats.median, range),
        median_value: year_stats.median,
        min: stat_min,
        max: stat_max,
        stat: Map.fetch!(@translation, column)
      }
    end

    defp normalize(stat, {min, max}) when is_number(stat) do
      25 + 100 * (stat - min) / (max - min)
    end

    defp normalize(stat = %Decimal{}, {min, max}) do
      min = Decimal.from_float(min)
      max = Decimal.from_float(max)

      Decimal.add(
        25,
        Decimal.mult(100, Decimal.div(Decimal.sub(stat, min), Decimal.sub(max, min)))
      )
    end
  end
end
