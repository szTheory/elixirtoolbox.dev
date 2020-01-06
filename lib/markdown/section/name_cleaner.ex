defmodule Markdown.Section.NameCleaner do
  def clean_section_name(section_name) do
    ~r/^\#\# (?<name>.+)$/
    |> Regex.named_captures(section_name)
    |> Map.get("name")
  end
end
