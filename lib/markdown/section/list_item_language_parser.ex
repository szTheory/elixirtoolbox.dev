defmodule Markdown.Section.ListItemLanguageParser do
  @moduledoc """
  Parse the programming language from a list item
  """

  def parse_language(list_item) do
    name = Map.get(list_item, :name)

    language_for_name(name)
  end

  defp language_for_name(name) do
    case name do
      "[erl]" -> :erlang
      "[ex]" -> :elixir
      "[glm]" -> :gleam
      true -> throw("Could not parse language for #{name}")
    end
  end
end
