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
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.map(&count_scores/1)
    |> List.flatten()
    |> Enum.sum()
  end

  defp count_scores({start, last}) do
    Enum.map(start..last, fn id ->
      case is_invalid2(id) do
        true -> id
        false -> 0
      end
    end)
  end

  defp is_invalid2(id) do
    # Fine and Wilf's theorem
    digits = Integer.digits(id)
    combined = digits ++ digits

    Enum.slice(combined, 1, length(combined) - 2)
    |> Enum.join()
    |> String.contains?(Integer.to_string(id))
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
