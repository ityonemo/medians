defmodule MediansWeb.SchoolHTML do
  use MediansWeb, :html

  embed_templates "school_html/*"

  # @headers %Db.Year{} |> Map.from_struct |> Map.delete(~w(__meta__ inserted_at updated_at)a) |> Map.keys

  def school_headers(_assigns) do
    assigns = %{headers: @headers}

    ~H"""
    <th :for={header <- @headers}><%= header %></th>
    """
  end
end
