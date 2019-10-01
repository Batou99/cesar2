defmodule Cesar2 do
  @moduledoc """
  Documentation for Cesar2.
  """

  @low ?!
  @high ?~
  @printable_range @low..@high

  @spec encrypt(binary() | [char()], integer()) :: binary() | [char()]
  def encrypt(input, key)

  def encrypt([], _key), do: []

  def encrypt([head | tail], key) do
    [shift(head, key) | encrypt(tail, key)]
  end

  def encrypt(string, key) do
    string
    |> String.to_charlist
    |> encrypt(key)
    |> to_string
  end

  @spec decrypt(binary(), integer()) :: binary()
  def decrypt(string, key) do
    encrypt(string, -key)
  end
  
  @spec normalize(char()) :: char()
  def normalize(char) do
    char - @low
  end

  @spec denormalize(char()) :: char()
  def denormalize(char) do
    char + @low
  end

  @spec shift(char(), integer()) :: char()
  def shift(char, amount)

  def shift(char, amount) when char in @printable_range do
    (char + amount)
    |> normalize
    |> modulo(Enum.count(@printable_range))
    |> denormalize
  end

  def shift(char, _amount) do
    char
  end

  def low, do: @low
  def high, do: @high

  defp modulo(n, q) when is_integer(n) and n == abs(n) do
    rem(n, q)
  end

  defp modulo(n, q) when is_integer(n) do
    rem(n, q) + q
  end
end
