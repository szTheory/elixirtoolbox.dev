defmodule ReadmeDownloader do
  use Tesla
  plug(Tesla.Middleware.BaseUrl, "https://raw.githubusercontent.com/")

  def download() do
    {:ok, response} = get("szTheory/elixir-bestlib/master/README.md")
    response.body
  end
end
