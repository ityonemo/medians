defmodule MediansWeb.PageHTML do
  use MediansWeb, :html

  embed_templates "page_html/*"

  def school_options(assigns) do
    ~H"""
    <option :for={school <- @schools} value={school.id}><%= school.name %></option>
    """
  end
end
