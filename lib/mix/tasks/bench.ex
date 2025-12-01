defmodule Mix.Tasks.Aoc.Bench do
  use Mix.Task

  def run([day, part]) do
    {day_module, part_func} = Aoc2025.Mix.Utils.get_solver(day, part)
    {:ok, _} = Application.ensure_all_started(:httpoison)
    {:ok, input} = Aoc2025.Inputs.get_day(day)

    Benchee.run(%{
      "day#{day} - part#{part}" => fn ->
        apply(day_module, part_func, [input])
      end
    })
  end
end
