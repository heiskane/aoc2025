defmodule Aoc2025.Day6 do
  alias Aoc2025.Grid
  alias Aoc2025.Point

  @operators %{
    "*" => &Kernel.*/2,
    "+" => &Kernel.+/2
  }

  def pre_process_input(input) do
    _ = """
    123 328  51 64 
    45 64  387 23 
    6 98  215 314
    *   +   *   +  
    """

    input
  end

  def part1(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1))
      |> Grid.parse()

    Enum.map(0..(grid.width - 1), fn col ->
      Enum.reduce(0..(grid.height - 1), [], fn row, acc ->
        item = Grid.at(grid, Point.new(row, col))
        [item | acc]
      end)
    end)
    |> Enum.map(&parse_column/1)
    |> Enum.sum()
  end

  def parse_column([op, first | rest]) do
    Enum.reduce(rest, String.to_integer(first), fn item, acc ->
      String.to_integer(item)
      |> @operators[op].(acc)
    end)
  end
end
