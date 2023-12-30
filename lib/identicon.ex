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
    |> set_identicon_hash
  end

  defp set_identicon_hash(hashed_input) do
    %Identicon{hash: hashed_input}
  end

  defp set_identicon_color(%Identicon{hash: [r, g, b | _]} = identicon) do
    %Identicon{identicon | color: {r, g, b}}
  end

  defp build_grid(%Identicon{hash: hash} = identicon) do
    set_identicon_grid(
      identicon,
      hash
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()
      |> filter_odd_squares
    )
  end

  defp set_identicon_grid(identicon, grid) do
    %Identicon{identicon | grid: grid}
  end

  defp mirror_row([first, second | _] = row) do
    row ++ [second, first]
  end

  defp filter_odd_squares(grid) do
    Enum.filter(grid, fn {num, _index} -> rem(num, 2) == 0 end)
  end
end
