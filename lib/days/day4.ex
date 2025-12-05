defmodule Aoc2025.Day4 do
  alias Aoc2025.Grid
  alias Aoc2025.Point

  def part1(input) do
    grid =
      input
      |> Grid.parse()

    grid
    |> Grid.points()
    |> Enum.filter(&is_roll(grid, &1))
    |> Enum.filter(&is_removable(grid, &1))
    |> Enum.count()
  end

  def part2(input) do
    grid =
      input
      |> Grid.parse()

    roll_count =
      grid
      |> find_rolls()
      |> Enum.count()

    rolls_left =
      removal_loop(grid)
      |> find_rolls()
      |> Enum.count()

    roll_count - rolls_left
  end

  def removal_loop(grid) do
    removables = find_removables(grid)

    case length(removables) do
      0 -> grid
      _ -> remove_rolls(grid, removables) |> removal_loop()
    end
  end

  def remove_rolls(grid, removables) do
    Enum.reduce(removables, grid, fn roll, acc ->
      Grid.update_at(acc, roll, ".")
    end)
  end

  def find_rolls(grid) do
    grid
    |> Grid.points()
    |> Enum.filter(&is_roll(grid, &1))
  end

  def find_removables(grid) do
    grid
    |> find_rolls()
    |> Enum.filter(&is_removable(grid, &1))
  end

  def is_roll(grid, point), do: Grid.at(grid, point) == "@"

  def is_removable(%Grid{} = grid, %Point{} = point) do
    [:up_left, :up, :up_right, :right, :bottom_right, :bottom, :bottom_left, :left]
    |> Enum.map(&Point.move(point, &1))
    |> Enum.map(&Grid.at(grid, &1))
    |> Enum.filter(&(&1 == "@"))
    |> Enum.count() < 4
  end
end
