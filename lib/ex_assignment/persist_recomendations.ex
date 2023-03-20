defmodule ExAssignment.PersistRecomendations do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  def add(item) do
    GenServer.cast(__MODULE__, item)
  end

  def check do
    GenServer.call(__MODULE__, :todo)
  end

  def remove(item) do
    GenServer.cast(__MODULE__, {:remove, item})
  end

  @impl true
  def handle_call(:todo, _, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:remove, item}, list) do
    updated_list = Enum.reject(list, fn i -> i == item end)
    {:noreply, updated_list}
  end

  @impl true
  def handle_cast(item, list) do
    updated_list = Enum.concat([todo: item], list)
    {:noreply, updated_list}
  end
end
