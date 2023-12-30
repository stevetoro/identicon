defmodule Identicon do
  defstruct hash: [0], color: {0, 0, 0}, grid: [{0, 0}], pixel_map: [{{0, 0}, {0, 0}}]

  def new(input) do
    input
    |> generate_hash
    |> set_identicon_color
    |> build_grid
    |> build_pixel_map
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

  defp mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  defp odd_squares({num, _index}) do
    rem(num, 2) == 0
  end

  defp build_pixel_map(%Identicon{grid: grid} = identicon) do
    grid
    |> Enum.map(&calculate_pixel_coordinates/1)
    |> then(&%Identicon{identicon | pixel_map: &1})
  end

  defp calculate_pixel_coordinates({_num, index}) do
    horizontal = rem(index, 5) * 50
    vertical = div(index, 5) * 50

    top_left = {horizontal, vertical}
    bottom_right = {horizontal + 50, vertical + 50}

    {top_left, bottom_right}
  end
end
