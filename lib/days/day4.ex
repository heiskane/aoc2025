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
    |> Enum.filter(&is_removable(grid, &1))
    |> Enum.count()
  end

  def part2(input) do
    grid =
      input
      |> Grid.new()

    grid2 =
      Enum.reduce_while(0..1000, grid, fn _, acc1 ->
        removables = find_removables(acc1)

        case length(removables) do
          0 ->
            {:halt, acc1}

          _ ->
            grid =
              Enum.reduce(removables, acc1, fn roll, acc2 ->
                Grid.update_at(acc2, roll, ".")
              end)

            {:cont, grid}
        end
      end)

    # |> IO.puts()

    asdf =
      grid
      |> find_rolls()
      |> Enum.count()

    qwer = grid2
    |> find_rolls()
    |> Enum.count()

    asdf - qwer
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
