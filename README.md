# Identicon

An Elixir library for generating identicon images.

## Installation

This package can be installed by adding `identicon` to your list of dependencies in `mix.exs`:

```elixir
defp deps do
  [
    {:identicon, github: "stevetoro/identicon"}
  ]
end
```

## Usage

Pass a string to `Identicon.new/1` and expect a binary representation of your identicon image.

```elixir
image = Identicon.new("elixir")
<<137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 250, 0,
  0, 0, 250, 8, 2, 0, 0, 0, 7, 142, 205, 106, 0, 0, 7, 10, 73, 68, 65, 84, 120,
  156, 237, 146, 193, 137, 28, 80, 20, ...>>
```

You can either keep this representation in memory, encode into a more preferable format, or write to a file right away depending on your usecase.

```elixir
image = Identicon.new("phoenix")
:ok = File.write("phoenix.png", image)
```
