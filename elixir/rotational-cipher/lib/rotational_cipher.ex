defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&to_rotate(&1, shift))
    |> List.to_string()
  end

  defp to_rotate(char, shift) when char in ?a..?z, do: rem(char - ?a + shift, 26) + ?a
  defp to_rotate(char, shift) when char in ?A..?Z, do: rem(char - ?A + shift, 26) + ?A
  defp to_rotate(char, _shift), do: char
end
