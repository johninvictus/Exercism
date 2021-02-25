defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    for x <- list, fun.(x), do: x
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    list
    |> do_func(fun, false)
    |> Enum.reverse()
  end

  defp do_func(list, fun, keep?) do
    list
    |> Enum.reduce([], fn value, cumm ->
      v =
        keep?
        |> keep_check(fun.(value))
        |> do_keep(value)

      v ++ cumm
    end)
  end

  defp keep_check(true, value), do: value
  defp keep_check(false, value), do: !value

  defp do_keep(true, value), do: [value]
  defp do_keep(false, value), do: []
end
