defmodule Cesar2 do
  @moduledoc """
  Documentation for Cesar2.
  """
  @spec encrypt(binary() | [char()], integer()) :: binary() | char()
  def encrypt([], key), do: []

  def encrypt([head | tail], key) do
    []
  end

  def encrypt(string, key) do
    string
    |> String.to_charlist
    |> encrypt(key)
    |> to_string
  end

  def decrypt(string, key) do
    encrypt(string, -key)
  end
end
