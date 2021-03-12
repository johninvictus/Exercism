defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.trim()
    |> String.replace("-", " ")
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.reduce("", fn word, cumm ->
      cumm <> get_first_letter(word)
    end)
  end

  defp get_first_letter(word) do
    word
    |> String.codepoints()
    |> Enum.at(0)
    |> String.capitalize()
  end

end
