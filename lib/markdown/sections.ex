defmodule Markdown.Sections do
  alias Markdown.Section

  def list do
    # IO.puts(MarkdownBuilder.build())
    markdown_sections()
    |> IO.inspect()

    markdown_sections()
  end

  defp markdown_sections do
    Markdown.Builder.build()
    |> split_by_section
    |> Enum.chunk_every(2)
    |> Enum.map(&%{section: List.first(&1), list: List.last(&1)})
    |> Enum.map(&Section.Cleaner.clean_markdown_section(&1))
  end

  defp split_by_section(markdown_text) do
    ~r/^\#\# (?<section_name>.+)$/m
    |> Regex.split(markdown_text, include_captures: true)
    |> Enum.slice(1..-1)
  end
end
