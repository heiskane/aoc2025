defmodule Aoc2025.Point do
  defstruct x: 0, y: 0
  def new(x \\ 0, y \\ 0), do: %__MODULE__{x: x, y: y}

  def add(%__MODULE__{} = p1, %__MODULE__{} = p2),
    do: %__MODULE__{x: p1.x + p2.x, y: p1.y + p2.y}

  def subtract(%__MODULE__{} = p1, %__MODULE__{} = p2),
    do: %__MODULE__{x: p1.x - p2.x, y: p1.y - p2.y}

  def move(%__MODULE__{x: x, y: y}, direction, distance \\ 1) do
    case direction do
      :up_left -> %__MODULE__{x: x - distance, y: y - distance}
      :up -> %__MODULE__{x: x - distance, y: y}
      :up_right -> %__MODULE__{x: x - distance, y: y + distance}
      :right -> %__MODULE__{x: x, y: y + distance}
      :bottom_right -> %__MODULE__{x: x + distance, y: y + distance}
      :bottom -> %__MODULE__{x: x + distance, y: y}
      :bottom_left -> %__MODULE__{x: x + distance, y: y - distance}
      :left -> %__MODULE__{x: x, y: y - distance}
    end
  end
end
