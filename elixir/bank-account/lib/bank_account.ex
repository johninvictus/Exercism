defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  use GenServer

  defstruct balance: 0

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    case Process.alive?(account) do
      true ->
        GenServer.call(account, :balance)

      false ->
        {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    case Process.alive?(account) do
      true ->
        GenServer.cast(account, {:update, amount})

      false ->
        {:error, :account_closed}
    end
  end

  def init(_) do
    {:ok, %BankAccount{}}
  end

  def handle_call(:balance, _from, %BankAccount{balance: b} = state) do
    {:reply, b, state}
  end

  def handle_cast({:update, amount}, account) do
    {:noreply, %{account | balance: account.balance + amount}}
  end
end
