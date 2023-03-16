defmodule MediansWeb.SchoolHTML do
  use MediansWeb, :html

  embed_templates "school_html/*"

  @categories [
    "year",
    "rank",
    "LSAT score",
    "GPA",
    "GRE verbal score",
    "GRE quantitative score",
    "GRE writing score"
  ]
  @headers ~w(L75 L50 L25 G75 G50 G25 gre75v gre50v gre25v gre75q gre50q gre25q gre75w gre50w gre25w)a
  @slices Db.Fields.slices()

  defp rowspan(category) when category in ["year", "rank"], do: 2
  defp rowspan(_category), do: 1

  defp colspan(category) when category in ["year", "rank"], do: 1
  defp colspan(_category), do: 3

  def school_headers(_assigns) do
    assigns = %{categories: @categories, headers: @headers, slices: @slices}

    ~H"""
    <tr>
      <th :for={category <- @categories} rowspan={rowspan(category)} colspan={colspan(category)}>
        <%= category %>
      </th>
    </tr>
    <tr>
      <th :for={header <- @headers}><%= @slices[header] %></th>
    </tr>
    """
  end

  def school_data(assigns) do
    assigns = Map.put(assigns, :headers, @headers)

    ~H"""
    <tr :for={year_data <- @year_data}>
      <td><%= year_data.rank.year %></td>
      <td><%= year_data.rank %></td>
      <td :for={header <- @headers}><a href={~p|/schools/#{@school.id}/?year=#{year_data.rank.year}&column=#{header}|}><%= Map.fetch!(year_data, header) %></a></td>
    </tr>
    """
  end
end
