defmodule Aoc2025.Grid do
  alias Aoc2025.Point

  defstruct [:height, :width, :rows]

  defmacro in_bounds(grid, x, y) do
    quote do
      0 <= unquote(x) and unquote(x) <= unquote(grid).width - 1 and
        (0 <= unquote(y) and unquote(y) <= unquote(grid).height - 1)
    end
  end

  def new(string) do
    rows =
      string
      |> String.trim_trailing()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))

    height = length(rows)
    width = length(hd(rows))

    %__MODULE__{height: height, width: width, rows: rows}
  end

  def at(grid, point) when not in_bounds(grid, point.x, point.y), do: nil
  def at(grid, point), do: Enum.at(grid.rows, point.x) |> Enum.at(point.y)

  def find(%__MODULE__{} = grid, element) do
    Enum.with_index(grid.rows)
    |> Enum.reduce_while(nil, fn {row, x}, _acc ->
      case Enum.find_index(row, &(&1 == element)) do
        nil -> {:cont, nil}
        y -> {:halt, {x, y}}
      end
    end)
  end

  def update_at(%__MODULE__{} = grid, %Point{} = p, new) do
    List.update_at(grid.rows, p.x, fn row ->
      List.update_at(row, p.y, fn _ -> new end)
    end)
  end

  def points(%__MODULE__{} = grid) do
    Enum.flat_map(0..(grid.width - 1), fn x ->
      Enum.map(0..(grid.height - 1), fn y ->
        Point.new(x, y)
      end)
    end)
  end
end
