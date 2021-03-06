defmodule Markdown.Section.ListItemNameParser do
  @moduledoc """
  Parse the library name from a list item
  """

  def parse_name(list_item) do
    url = Map.get(list_item, :url)

    name_for_url(url)
  end

  # For some URLs we can infer the name of the library from
  # the URL path. For example https://hex.pm/packages/dice means
  # the name of the package is "dice"
  defp name_for_url(url) do
    if can_infer_name_for_url?(url) do
      case url do
        "https://hexdocs.pm/elixir/Kernel.html" ->
          "Elixir Standard Library"

        "http://erlang.org/doc/apps/stdlib/index.html" ->
          "Erlang Standard Library"

        _ ->
          if String.contains?(url, "marketplace.visualstudio.com") do
            String.replace(url, "https://marketplace.visualstudio.com/items?itemName=", "")
          else
            url
            |> String.replace(~r/\/+$/, "")
            |> String.split("/")
            |> List.last()
            |> String.replace(".html", "")
            |> String.trim()
          end
      end
    else
      url
    end
  end

  defp can_infer_name_for_url?(url) do
    [
      "github.com",
      "hex.pm",
      "hexdocs.pm",
      "gitlab.com",
      "bitbucket.org",
      "gitgud.io",
      "marketplace.visualstudio.com"
    ]
    |> Enum.any?(&String.contains?(url, &1))
  end
end
