defmodule MarkdownBySection do
  def by_sections do
    # IO.puts(MarkdownBuilder.build())
    markdown_sections()
    |> IO.inspect()

    markdown_sections()
  end

  defp markdown_sections do
    MarkdownBuilder.build()
    |> split_by_section
    |> Enum.chunk_every(2)
    |> Enum.map(&%{section: List.first(&1), list: List.last(&1)})
    |> Enum.map(&clean_markdown_section(&1))
  end

  defp clean_markdown_section(markdown_section) do
    IO.inspect(markdown_section)

    %{
      section_name: clean_section_name(markdown_section[:section]),
      # section_name: markdown_section[:section],
      list: hashify_section_list(markdown_section[:list])
    }
  end

  defp clean_section_name(section_name) do
    ~r/^\#\# (?<name>.+)$/
    |> Regex.named_captures(section_name)
    |> Map.get("name")
  end

  defp hashify_section_list(raw_section_list) do
    # {:ok, html_doc, []} = Earmark.as_html(section_list)
    # html_doc
    raw_section_list
    |> clean_section_list
    |> Enum.map(fn x ->
      {:ok, html, _} = Earmark.as_html(x)

      html
      |> hash_from_list_item_html
    end)
    |> List.flatten()
  end

  defp hash_from_list_item_html(html) do
    list =
      list_item_html_links(html)
      |> Enum.map(fn x ->
        # IO.inspect(x)
        {_, attrs, [name]} = x

        href =
          Enum.find_value(attrs, fn x ->
            {"href", url} = x
            url
          end)

        %{name: name, url: href}
      end)

    category_name =
      list
      |> List.first()
      |> Map.get(:name)

    transformed_list =
      list
      |> Enum.map(fn x ->
        expand_list_item(category_name, x)
      end)
      |> Enum.map(fn x ->
        Map.delete(x, :name)
      end)

    %{name: category_name, entries: transformed_list}
  end

  defp expand_list_item(category_name, list_item) do
    # IO.inspect(list_item)
    name = Map.get(list_item, :name)
    type = if Regex.match?(~r/\[erl/, name), do: :erlang, else: :elixir

    is_num = Regex.match?(~r/\[(\d)\]/, name)

    num =
      if is_num do
        name
        |> String.replace(~r/\[(\d)\]/, "\\g{1}")
        |> String.trim()
      else
        "1"
      end

    list_item
    |> Map.put(:name, category_name)
    |> Map.put(:type, type)
    |> Map.put(:num, String.to_integer(num))
  end

  defp list_item_html_links(html) do
    {:ok, document} = Floki.parse_document(html)
    Floki.find(document, "a")
  end

  defp clean_section_list(raw_section_list) do
    raw_section_list
    |> String.split("\n")
    |> Enum.map(&String.replace(&1, ~r/^\- (.+)$/, "\\g{1}"))
    |> Enum.reject(&(String.trim(&1) == ""))
  end

  defp split_by_section(markdown_text) do
    ~r/^\#\# (?<section_name>.+)$/m
    |> Regex.split(markdown_text, include_captures: true)
    |> Enum.slice(1..-1)
  end
end
