defmodule Aoc2025.Day4 do
  alias Aoc2025.Grid
  alias Aoc2025.Point

  def part1(input) do
    grid =
      input
      |> Grid.new()

    grid
    |> Grid.points()
    |> Enum.filter(&is_roll(grid, &1))
    |> Enum.filter(&(count_neighbours(grid, &1) < 4))
    |> Enum.count()
  end

  def is_roll(grid, point), do: Grid.at(grid, point) == "@"

  def count_neighbours(%Grid{} = grid, %Point{} = point) do
    [:up_left, :up, :up_right, :right, :bottom_right, :bottom, :bottom_left, :left]
    |> Enum.map(&Point.move(point, &1))
    |> Enum.map(&Grid.at(grid, &1))
    |> Enum.filter(&(&1 == "@"))
    |> Enum.count()
  end
end
