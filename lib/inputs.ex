defmodule Aoc2025.Inputs do
  require Logger

  @base_url URI.parse("https://adventofcode.com/2024/day/")

  def get_day(day) do
    case File.read(".cache/input#{day}.txt") do
      {:ok, content} ->
        Logger.debug("Using cached input file")
        {:ok, content}

      {:error, _} ->
        download(day)
    end
  end

  defp download(day) do
    Logger.debug("Downloading input")

    with {:ok, token} <- File.read(".token"),
         {:ok, input} <- http_get_input(day, token),
         {:ok, input} <- cache_input(day, input) do
      {:ok, input}
    end
  end

  defp http_get_input(day, token) do
    case HTTPoison.get!(URI.append_path(@base_url, "/#{day}/input"), %{},
           hackney: [
             cookie: [
               "session=#{token}"
             ]
           ]
         ) do
      %HTTPoison.Response{status_code: 200, body: body} ->
        {:ok, body}

      %HTTPoison.Response{status_code: status} ->
        {:error, "Unexpected response code while getting input: #{status}"}
    end
  end

  defp cache_input(day, input) do
    Logger.debug("Caching input to file")

    case File.write(".cache/input#{day}.txt", input) do
      :ok -> {:ok, input}
      {:error, reason} -> {:error, "Failed to save input to file because `#{reason}`"}
    end
  end
end
