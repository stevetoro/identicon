defmodule IdenticonTest do
  use ExUnit.Case

  test "Identicon.new should generate images deterministically" do
    file_names = ["elixir", "phoenix", "josevalim"]

    Enum.each(file_names, fn file_name ->
      image = File.read!("test/fixtures/#{file_name}.png") |> Base.encode64()

      Enum.each(1..2, fn _ ->
        identicon = Identicon.new(file_name) |> Base.encode64()
        assert image == identicon, "expected the generated image to match the test fixture"
      end)
    end)
  end
end
