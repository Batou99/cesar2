defmodule Reader do
  @moduledoc false

  def encrypt(filename, key) do
    process(filename, key, &Cesar2.encrypt/2)
  end

  def decrypt(filename, key) do
    process(filename, key, &Cesar2.decrypt/2)
  end

  def ml(filename) do
    test_string = File.stream!(filename) 
                  |> Enum.take(5) 
                  |> Enum.map(&String.trim/1) 
                  |> Enum.join(" ") 
                  |> String.replace(~r/[".,]/, "")
    key = ML.find_decrypt_key(test_string)
    decrypt(filename, key)
  end

  defp process(filename, key, f) do
    filename
    |> File.stream!
    |> Enum.map(fn (line) -> f.(line, key) end)
    |> IO.write
  end
end

