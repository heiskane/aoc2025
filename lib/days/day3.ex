defmodule Aoc2025.Day3 do
  def part1(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.codepoints(&1))
    |> Enum.map(&find_largest(&1, 0))
    |> Enum.sum()
  end

  def part2(_input) do
    input = """
    9129
    """

    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.codepoints(&1))
  end

  def find_largest([], largest), do: largest

  def find_largest([head | tail], largest) do
    largest =
      Enum.reduce(tail, 0, fn i, acc ->
        String.to_integer(head <> i)
        |> max(acc)
      end)
      |> max(largest)

    find_largest(tail, largest)
  end
end
