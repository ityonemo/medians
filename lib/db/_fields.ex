defmodule Db.Fields do
  @moduledoc """
  translation of field names into english
  """

  @translation %{
    L75: "LSAT 75th percentile score",
    L50: "LSAT median score",
    L25: "LSAT 25th percentile score",
    G75: "75th percentile GPA",
    G50: "median GPA",
    G25: "25th percentile GPA",
    gre75v: "GRE verbal 75th percentile score",
    gre50v: "GRE verbal median score",
    gre25v: "GRE verbal 25th percentile score",
    gre75q: "GRE quantitative 75th percentile score",
    gre50q: "GRE quantitative median score",
    gre25q: "GRE quantitative 25th percentile score",
    gre75w: "GRE writing 75th percentile score",
    gre50w: "GRE writing median score",
    gre25w: "GRE writing 25th percentile score"
  }

  def translation, do: @translation

  @class %{
    L75: "LSAT score",
    L50: "LSAT score",
    L25: "LSAT score",
    G75: "GPA",
    G50: "GPA",
    G25: "GPA",
    gre75v: "GRE verbal score",
    gre50v: "GRE verbal score",
    gre25v: "GRE verbal score",
    gre75q: "GRE quantitative score",
    gre50q: "GRE quantitative score",
    gre25q: "GRE quantitative score",
    gre75w: "GRE writing score",
    gre50w: "GRE writing score",
    gre25w: "GRE writing score"
  }

  def class, do: @class

  @slice %{
    L75: "75th percentile",
    L50: "median",
    L25: "25th percentile",
    G75: "75th percentile",
    G50: "median",
    G25: "25th percentile",
    gre75v: "75th percentile",
    gre50v: "median",
    gre25v: "25th percentile",
    gre75q: "75th percentile",
    gre50q: "median",
    gre25q: "25th percentile",
    gre75w: "75th percentile",
    gre50w: "median",
    gre25w: "25th percentile"
  }

  def slice, do: @slice
end
