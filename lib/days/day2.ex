defmodule Aoc2025.Day2 do
  def part1(input) do
    input
    |> String.trim_trailing()
    |> String.split(",", trim: true)
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.map(&count_invalid(&1, []))
    |> List.flatten()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.trim_trailing()
    |> String.split(",", trim: true)
    |> Stream.flat_map(fn row ->
      [a, b] = String.split(row, "-")
      Enum.to_list(String.to_integer(a)..String.to_integer(b))
    end)
    |> Stream.filter(&is_invalid2/1)
    |> Enum.sum()
  end

  defp is_invalid2(id) do
    # Fine and Wilf's theorem
    digits = Integer.to_string(id)

    String.slice(digits <> digits, 1, String.length(digits) * 2 - 2)
    |> String.contains?(digits)
  end

  defp count_invalid({start, last}, invalids) when start > last, do: invalids

  defp count_invalid({start, last}, invalids) do
    invalids =
      case is_invalid(start) do
        true -> [start | invalids]
        false -> invalids
      end

    count_invalid({start + 1, last}, invalids)
  end

  defp is_invalid(id) do
    digits = Integer.digits(id)

    with 0 <- rem(length(digits), 2) do
      first = Enum.slice(digits, 0, div(length(digits), 2))
      last = Enum.slice(digits, div(length(digits), 2), length(digits))
      if first == last, do: true, else: false
    else
      _ -> false
    end
  end
end
