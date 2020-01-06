defmodule Markdown.Section.Cleaner do
  alias Markdown.Section.ListCleaner
  alias Markdown.Section.NameCleaner

  def clean_markdown_section(markdown_section) do
    IO.inspect(markdown_section)

    %{
      section_name: section_name(markdown_section),
      list: section_list(markdown_section)
    }
  end

  defp section_name(markdown_section) do
    markdown_section[:section]
    |> NameCleaner.clean_section_name()
  end

  defp section_list(markdown_section) do
    markdown_section[:list]
    |> ListCleaner.hashify_section_list()
  end
end
