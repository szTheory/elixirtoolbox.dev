# ElixirToolbox Website

Website for [elixirtoolbox.dev](https://elixirtoolbox.dev), a curated list of Elixir libraries. Inspired by [Ruby Toolbox](https://ruby-toolbox.com) and [Clojure Toolbox](https://clojure-toolbox.com).

## Suggest a change

Simply open a PR on [the BEAM Toolbox Github project](https://github.com/szTheory/beamtoolbox) with your edit. Once it's merged in the website will automatically rebuild and deploy.

## JSON API

A JSON API is available [here](https://elixirtoolbox.dev/index.json)

## Build website

To build the website, run this command.

    mix generate

It will output the results to `build/*`. Then you can view the website at `build/index.html` or `build/index.json`.

## Run website locally

```bash
mix generate
cd build
ruby -run -e httpd . -p 9090
```

Then open http://localhost:9090 in your browser.