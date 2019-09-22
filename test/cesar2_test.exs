defmodule Cesar2Test do
  use ExUnit.Case
  use PropCheck
  doctest Cesar2

  def printable_string do
    printable_charlist_gen = such_that s <- char_list(), when: :io_lib.printable_latin1_list(s)

    let s <- printable_charlist_gen, do: to_string(s)
  end

  def shiftable_char do
    integer(Cesar2.low, Cesar2.high)
  end

  property "encrypt-decrypt: inverse", [{:constraint_tries, 500}, {:numtests, 1000}] do
    forall {text, key} <- {printable_string(), integer()} do
      (text |> Cesar2.encrypt(key) |> Cesar2.decrypt(key)) == text
    end
  end

  describe "Normalize/Denormalize" do
    property "value" do
      forall {letter} <- {shiftable_char()} do
        Cesar2.normalize(letter) <= Cesar2.high-Cesar2.low
      end
    end

    test "first to zero" do
      assert Cesar2.normalize(Cesar2.low) == 0
    end

    test "zero to first" do
      assert Cesar2.denormalize(0) == Cesar2.low
    end

    property "inverse" do
      forall {letter} <- {integer()} do
        (Cesar2.normalize(letter) |> Cesar2.denormalize) == letter &&
          (Cesar2.denormalize(letter) |> Cesar2.normalize) == letter
      end
    end
  end

  describe "shift" do
    property "inverse" do
      forall {letter, key} <- {integer(), integer()} do
        Cesar2.shift(letter, key) |> Cesar2.shift(-key) == letter
      end
    end
  end
end
