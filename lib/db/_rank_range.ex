defmodule Db.RankRange do
  @moduledoc """
  Specialized Ecto type to ingress content from postgres ranges.

  Designed to accept elixir ranges integers, or strings and convert them correctly via
  Ecto schemata.

  heavily modified from: https://pedroassumpcao.ghost.io/using-postgres-range-data-type-in-ecto/
  """

  # NB: in this code we use high/low verbiage with high meaning a lower integer
  # (this is a 'higher' rank)

  @behaviour Ecto.Type

  def type, do: :int4range

  def embed_as(_), do: :self

  def cast("Unranked"), do: {:ok, nil}

  def cast(rank_string) when is_binary(rank_string) do
    with {high, "-" <> rest} <- Integer.parse(rank_string),
         {low, ""} <- Integer.parse(rest),
         true <- high < low do
      cast(high..low)
    else
      {rank, ""} -> cast(rank)
      _ -> :error
    end
  end

  def cast(rank) when is_integer(rank) do
    {:ok, [rank, rank]}
  end

  def cast(high..low) do
    {:ok, [high, low]}
  end

  def cast([high, low]) do
    {:ok, [high, low]}
  end

  def cast(_), do: :error

  def load(%Postgrex.Range{lower: high, upper: low}) do
    # not entirely sure why, but postgrex ranges for integers will
    # wind up representing them as n, n+1
    {:ok, high..(low - 1)}
  end

  def dump([high, low]) do
    {:ok, %Postgrex.Range{lower: high, upper: low}}
  end

  def dump(_), do: :error

  def equal?(a, b), do: a == b
end
