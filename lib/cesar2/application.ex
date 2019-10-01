defmodule Cesar2.Application do
  use Application

  def start(_type, _args) do
    children = [Dictionary]

    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
    Dictionary.load_data

    {:ok, pid}
  end
end
