defmodule Markdown.Sections do
  @moduledoc """
  Build a list of all library by section (category)
  """
  alias Markdown.Section

  @doc """
  A list of entries, by section.
  {
    list: [
      %{entries: [%{...}], name: "GeoNames API client"},
      %{entries: [%{...}], name: "Git hosting (GitHub)"},
      %{entries: [...], ...},
      %{...},
      ...
    ],
    section_name: "API Clients"
  }

  Each entry looks like this.
  %{type: :elixir, url: "https://hex.pm/packages/mandrill"}
  """
  def list do
    markdown_sections()
  end

  defp markdown_sections do
    Markdown.Builder.build_markdown()
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
