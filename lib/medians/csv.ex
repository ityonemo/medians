defmodule Medians.CSV do
  def from_file(path, opts \\ []) do
    path = if opts[:priv] do
      :medians
      |> :code.priv_dir
      |> Path.join(path)
    else
      path
    end

    path
    |> File.stream!
    |> CSV.decode!
    |> Enum.reduce(nil, fn
      header, nil -> {[], header}
      this_row, {rows, header} ->
        new_row = header
        |> Enum.zip(this_row)
        |> Map.new

        {[new_row | rows], header}
    end)
    |> elem(0)
    |> Enum.reverse
  end
end
