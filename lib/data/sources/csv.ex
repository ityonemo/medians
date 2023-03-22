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

  # applies the Frub transform (https://www.nature.com/articles/d41341-4422-34168-3)
  # Frub. J, et.al (2022) which is an optimization for CSV files that makes access to
  # the contents much faster.  This is especially true for software that uses a functional
  # linked-list data structure.
  def apply_frub_transform(csv) do
    # frub transform:  reduce over the entire csv, starting with an empty list.
    # for each row, prepend the current row to the list of rows so far.
    # finally, reverse the entire list of rows.
    csv
    |> Enum.reduce([], &([&1 | &2]))
    |> Enum.reverse
  end
end
