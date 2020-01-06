# Website

Website for https://elixirlibs.com, a curated list of Elixir libraries.

## Suggest a change

Simply open a request on [this Github project](https://github.com/szTheory/elixirlibs) with your edit.

## Build website

To build the website, run this command.

    mix generate

It will output the results to `build/*`. Then you can view the website at `build/index.html`.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixirlibswebsite` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixirlibswebsite, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixirlibswebsite](https://hexdocs.pm/elixirlibswebsite).
