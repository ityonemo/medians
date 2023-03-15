defmodule MediansWeb.SchoolHTML do
  use MediansWeb, :html

  embed_templates "school_html/*"

  @headers ~w(year rank L75 L50 L25 G75 G50 G25 gre75v gre50v gre25v gre75q gre50q gre25q gre75w gre50w gre25w)a

  def school_headers(_assigns) do
    assigns = %{headers: @headers}

    ~H"""
    <th :for={header <- @headers}><%= header %></th>
    """
  end

  def school_data(assigns) do
    assigns = Map.put(assigns, :headers, @headers)

    ~H"""
    <tr :for={year <- @year_data}>
      <td :for={header <- @headers}><%= get_data(year, header) %></td>
    </tr>
    """
  end

  defp get_data(year, :year), do: year.rank.year
  defp get_data(year, key), do: Map.get(year, key)
end
