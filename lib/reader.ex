defmodule Reader do
  @moduledoc false

  def encrypt(filename, key) do
    process(filename, key, &Cesar2.encrypt/2)
  end

  def decrypt(filename, key) do
    process(filename, key, &Cesar2.decrypt/2)
  end

  defp process(filename, key, f) do
    filename
    |> File.stream!
    |> Enum.map(fn (line) -> f.(line, key) end)
    |> IO.write
  end
end

