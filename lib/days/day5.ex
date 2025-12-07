defmodule Aoc2025.Day5 do
  def pre_process_input(input) do
    """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

    input
  end

  def part1(input) do
    [ranges, ids] =
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&String.split/1)

    ranges =
      ranges
      |> Enum.map(&String.split(&1, "-"))
      |> Enum.map(fn [start, stop] ->
        String.to_integer(start)..String.to_integer(stop)
      end)

    ids
    |> Enum.map(&String.to_integer/1)
    |> Enum.filter(fn id ->
      Enum.find_value(ranges, false, &(id in &1))
    end)
    |> Enum.count()
  end

  def part2(input) do
    [ranges, _ids] =
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&String.split/1)

    ranges
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn [start, stop] ->
      String.to_integer(start)..String.to_integer(stop)
    end)
    |> Enum.uniq()
    |> deduplicate([])
    |> deduplicate([])
    |> deduplicate([])
    |> deduplicate([])
    |> deduplicate([])
    |> deduplicate([])
    |> deduplicate([])
    |> deduplicate([])
    |> deduplicate([])
    |> dbg()
    |> Enum.map(&Range.size(&1))
    |> Enum.sum()

    # |> count_valid([], 0)
  end

  def deduplicate([], ranges), do: ranges

  def deduplicate([range | tail], ranges) do
    dbg({range, ranges})

    overlapping = Enum.filter(ranges, fn r -> not Range.disjoint?(r, range) end)

    unique_ranges =
      if length(overlapping) == 0 do
        [range]
      else
        overlapping
        |> Enum.reduce([], fn overlap, acc ->
          dbg({range, overlap, max(range.first, overlap.first)..min(range.last, overlap.last)})
          overlap_range = max(range.first, overlap.first)..min(range.last, overlap.last)
          # dbg({range.first..(overlap_range.first - 1), (overlap_range.last + 1)..range.last})

          acc =
            case overlap_range == range do
              true ->
                acc

              false ->
                acc =
                  case range.first == overlap_range.first do
                    true -> acc
                    false -> [range.first..(overlap_range.first - 1) | acc]
                  end

                case overlap_range.last == range.last do
                  true -> acc
                  false -> [(overlap_range.last + 1)..range.last | acc]
                end
            end

          dbg(acc)

          acc
        end)
      end

    dbg(unique_ranges)

    deduplicate(tail, unique_ranges ++ ranges)
  end

  def potato(range, overlapping) do
    
  end

  def count_valid([], _covered, count), do: count

  def count_valid([range | tail], covered, count) do
    dbg({range, length(tail), length(covered), count})
    overlapping = Enum.filter(covered, fn r -> not Range.disjoint?(r, range) end)

    overlap_count =
      if length(overlapping) > 0 do
        Enum.reduce(overlapping, [], fn overlap, acc ->
          dbg({range, overlap, max(range.first, overlap.first), min(range.last, overlap.last)})
          overlap_range = max(range.first, overlap.first)..min(range.last, overlap.last)
          dbg({range.first..overlap_range.first, overlap_range.last..range.last})
          start = max(range.first, overlap.first)
          stop = min(range.last, overlap.last)
          # dbg(Range.size(start..stop))
          [Enum.to_list(start..stop) | acc]
        end)
        |> List.flatten()
        |> Enum.uniq()
        |> Enum.count()
      else
        0
      end

    count_valid(tail, [range | covered], count + (Range.size(range) - overlap_count))
  end
end
