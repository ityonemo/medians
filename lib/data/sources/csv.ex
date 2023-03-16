defmodule Data.Sources.CSV do
  def from_file!(path, opts \\ []) do
    path =
      if opts[:priv] do
        :medians
        |> :code.priv_dir()
        |> Path.join(path)
      else
        path
      end

    path
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.to_list()
  end
end
