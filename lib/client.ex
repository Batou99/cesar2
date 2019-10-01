defmodule Client do
  @moduledoc false

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  defp parse_args(args) do
    parse = OptionParser.parse(
      args,
      strict:  [key: :integer, encrypt: :string, decrypt: :string, ml: :string],
      aliases: [e: :encrypt, d: :decrypt, k: :key, m: :ml]
    )
    case parse do
      {[encrypt: filename, key: key], [], []} ->
        {"encrypt", filename, key}
      {[decrypt: filename, key: key], [], []} ->
        {"decrypt", filename, key}
      {[ml: filename], [], []} ->
        {"ml", filename}
    end
  end

  defp process({"encrypt", file, key}) do
    Reader.encrypt(file, key)
  end

  defp process({"decrypt", file, key}) do
    Reader.decrypt(file, key)
  end

  defp process({"ml", file}) do
    Reader.ml(file)
  end
end

