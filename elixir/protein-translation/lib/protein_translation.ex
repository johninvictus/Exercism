defmodule ProteinTranslation do
  @codon %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    # rna
    # |> String.codepoints()
    # |> Enum.chunk_every(3)
    # |> Enum.map(&Enum.join/1)

    splitted = for <<x::binary-3 <- rna>>, do: x

    splitted
    |> of_rna([])
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codon, codon) do
      :error -> {:error, "invalid codon"}
      res -> res
    end
  end

  defp of_rna([], proteins), do: {:ok, proteins}
  defp of_rna([h_c | t_codons], proteins) do
    case of_codon(h_c) do
      {:ok, "STOP"} -> {:ok, proteins}
      {:ok, protein} -> of_rna(t_codons, proteins ++ [protein])
      {:error, _} -> {:error, "invalid RNA"}
    end
  end
end
