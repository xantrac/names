defmodule Names.FirstSupervisor do
  use DynamicSupervisor

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, [], name: :"#{__MODULE__}#{Names.uniq_integer()}")
  end

  def init(_opts) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(pid) do
    Enum.map(1..2, fn _ ->
      DynamicSupervisor.start_child(pid, Names.SecondServer)
    end)
  end
end
