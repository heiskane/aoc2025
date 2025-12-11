defmodule Aoc2025.Grid do
  alias Aoc2025.Point

  defstruct [:height, :width, :items]

  defmacro in_bounds(grid, x, y) do
    quote do
      0 <= unquote(x) and unquote(x) <= unquote(grid).width - 1 and
        (0 <= unquote(y) and unquote(y) <= unquote(grid).height - 1)
    end
  end

  def parse(string) when is_bitstring(string) do
    rows =
      string
      |> String.trim_trailing()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))

    parse(rows)
  end

  def parse(rows) when is_list(rows) do
    height = length(rows)
    width = length(hd(rows))

    items =
      rows
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, x} ->
        Enum.with_index(row)
        |> Enum.map(fn {item, y} -> {x, y, item} end)
      end)
      |> Enum.reduce(%{}, fn {x, y, item}, acc ->
        Map.put(acc, {x, y}, item)
      end)

    %__MODULE__{height: height, width: width, items: items}
  end

  def at(grid, point), do: Map.get(grid.items, {point.x, point.y}, nil)

  def update_at(%__MODULE__{} = grid, %Point{} = p, new),
    do: %__MODULE__{grid | items: Map.replace(grid.items, {p.x, p.y}, new)}

  def points(%__MODULE__{} = grid) do
    Map.keys(grid.items)
    |> Enum.map(fn {x, y} -> Point.new(x, y) end)
  end

  defimpl String.Chars, for: Aoc2025.Grid do
    def to_string(%Aoc2025.Grid{} = grid) do
      Enum.map(0..(grid.width - 1), fn x ->
        Enum.map(0..(grid.height - 1), fn y ->
          Map.get(grid.items, {x, y})
        end)
      end)
      |> Enum.map(&Enum.join(&1, ""))
      |> Enum.join("\n")
    end
  end
end
