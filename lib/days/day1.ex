defmodule Aoc2025.Day1 do
  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.split_at(&1, 1))
    |> Enum.map(fn {dir, count} -> {dir, String.to_integer(count)} end)
  end

  def part1(input) do
    input
    |> parse_input()
    |> parse_rotations(50, 0)
  end

  def part2(input) do
    input
    |> parse_input()
    |> parse_rotations2(50, 0)
  end

  defp parse_rotations([], _pos, score), do: score

  defp parse_rotations([{dir, count} | tail], pos, score) do
    pos =
      case dir do
        "L" -> Integer.mod(pos - count, 100)
        "R" -> Integer.mod(pos + count, 100)
      end

    score = if pos == 0, do: score + 1, else: score
    parse_rotations(tail, pos, score)
  end

  defp parse_rotations2([], _pos, score), do: score

  defp parse_rotations2([{dir, count} | tail], pos, score) do
    {pos, score} = move_dial(dir, pos, count, score)
    parse_rotations2(tail, pos, score)
  end

  defp move_dial(_dir, pos, 0, score), do: {pos, score}

  defp move_dial(dir, pos, count, score) do
    pos =
      case dir do
        "L" -> Integer.mod(pos - 1, 100)
        "R" -> Integer.mod(pos + 1, 100)
      end

    score = if pos == 0, do: score + 1, else: score
    move_dial(dir, pos, count - 1, score)
  end
end
