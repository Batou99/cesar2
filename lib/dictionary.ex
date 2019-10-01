defmodule Dictionary do
  use Agent

  @name __MODULE__

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def load_data do
    WordlistLoader.load_from_files
  end

  def count(""), do: 0
  def count([]), do: 0

  def count([head | tail]), do: count(head) + count(tail)

  def count(word) do
    found = Agent.get(@name, fn dict -> Map.has_key?(dict, word) end)

    if found, do: 1, else: 0
  end

  def put(key, value) do
    Agent.update(@name, &Map.put(&1, key, value))
  end
end

defmodule WordlistLoader do
  @path "data/words"

  # Load files in background
  def load_from_files do
    ?a..?z
    |> Enum.to_list
    |> to_string 
    |> String.split("", trim: true) 
    |> Stream.map(fn name -> Task.async(fn -> load_file(name) end) end)
    |> Enum.map(&Task.await/1)
  end

  defp load_file(letter) do
    filename = "#{@path}/#{letter}.txt"

    File.stream!(filename, [], :line) 
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Dictionary.put(&1, 1))
  end
end

