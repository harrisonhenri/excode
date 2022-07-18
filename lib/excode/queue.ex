defmodule Excode.Queue do
  use GenServer

  def start_link(initial_queue) when is_list(initial_queue) do
    GenServer.start_link(__MODULE__, initial_queue)
  end

  def enqueue(pid, element) do
    GenServer.cast(pid, {:enqueue, element})
  end

  def dequeue(pid) do
    GenServer.call(pid, :dequeue)
  end

  @impl true
  def init(queue) do
    {:ok, queue}
  end

  @impl true
  def handle_cast({:enqueue, element}, stack) do
    {:noreply, [stack | element]}
  end

  @impl true
  def handle_call(:dequeue, _from, [head | tail]) do
    {:reply, head, tail}
  end
end
