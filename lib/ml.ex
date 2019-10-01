defmodule ML do
  def find_decrypt_key(text) do
    {key, _} = 0..(Cesar2.high - Cesar2.low)
    |> Stream.map(fn(n) -> Task.async(fn -> {n, find_cost(text, n)} end) end) 
    |> Enum.map(&Task.await/1)
    |> Enum.min_by(fn({key, cost}) -> cost end)
    key
  end

    def decrypt(text) do
    key = find_decrypt_key(text)
    IO.puts Cesar2.decrypt(text, key)
  end

  def find_cost(text, key) do
    cryptext = Cesar2.decrypt(text, key)
    words = String.split(cryptext, " ")
    # Total words - found words
    # The lower the number the more amount of words found
    Enum.count(words) - Dictionary.count(words)
  end
end
