defmodule Identicon do
  defstruct hash: [], color: {0, 0, 0}, grid: [{0, 0}, {0, 1}]

  def new(input) do
    input
    |> generate_hash
    |> set_identicon_color
    |> build_grid
  end

  defp generate_hash(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
    |> then(&%Identicon{hash: &1})
  end

  defp set_identicon_color(%Identicon{hash: [r, g, b | _]} = identicon) do
    %Identicon{identicon | color: {r, g, b}}
  end

  defp build_grid(%Identicon{hash: hash} = identicon) do
    hash
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_row/1)
    |> List.flatten()
    |> Enum.with_index()
    |> Enum.filter(&odd_squares/1)
    |> then(&%Identicon{identicon | grid: &1})
  end

  defp mirror_row([first, second | _] = row) do
    row ++ [second, first]
  end

  defp odd_squares({num, _index}) do
    rem(num, 2) == 0
  end
end
