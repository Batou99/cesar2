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
      strict:  [key: :integer, encrypt: :string, decrypt: :string],
      aliases: [e: :encrypt, d: :decrypt, k: :key]
    )
    case parse do
      {[encrypt: filename, key: key], [], []} ->
        {"encrypt", filename, key}
      {[decrypt: filename, key: key], [], []} ->
        {"decrypt", filename, key}
    end
  end

  defp process({"encrypt", file, key}) do
    Reader.encrypt(file, key)
  end

  defp process({"decrypt", file, key}) do
    Reader.decrypt(file, key)
  end
end

