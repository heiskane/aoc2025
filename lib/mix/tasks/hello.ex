defmodule Mix.Tasks.Aoc.Run do
  @moduledoc "The hello mix task: `mix help hello`"
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run([day, part]) do
    dbg({day, part})

    if not (part == "1" or part == "2") do
      Mix.raise("Part number not in [1, 2]")
    end

    day_module = String.to_atom("Elixir.Aoc2025.Day" <> day)
    part_func = String.to_atom("part" <> part)

    if match?({:error, _}, Code.ensure_loaded(day_module)) do
      Mix.raise("Module #{day_module} not found")
    end

    if not Kernel.function_exported?(day_module, part_func, 0) do
      Mix.raise("Function #{part_func}/0 not exported in #{day_module}")
    end

    apply(day_module, part_func, [])
    |> dbg()
  end
end
