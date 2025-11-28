defmodule Aoc2025.Mix.Utils do
  def get_solver(day, part) do
    if not (part == "1" or part == "2") do
      Mix.raise("Part number not in [1, 2]")
    end

    part_func = String.to_atom("part" <> part)
    day_module = String.to_atom("Elixir.Aoc2025.Day" <> day)

    if match?({:error, _}, Code.ensure_loaded(day_module)) do
      Mix.raise("Module #{day_module} not found")
    end

    if not Kernel.function_exported?(day_module, part_func, 1) do
      Mix.raise("Function #{part_func}/0 not exported in #{day_module}")
    end

    {day_module, part_func}
  end
end
