defmodule Cesar2Test do
  use ExUnit.Case
  use PropCheck
  doctest Cesar2

  property "inverse" do
    forall {text, key} <- {binary(), integer()} do
      text
      |> Cesar2.encrypt(key)
      |> Cesar2.decrypt(key) == text
    end
  end
end
