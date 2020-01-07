defmodule Mix.Tasks.Generate do
  use Mix.Task

  @shortdoc "Generate the website."
  def run(_) do
    sections()
    |> generate_html!
    |> generate_json!

    IO.puts("DONE: Generated index.html and index.json")
  end

  defp sections do
    Markdown.Sections.list()
  end

  @spec generate_html!(list(any)) :: list(any)
  defp generate_html!(sections_list) do
    HtmlFileWriter.write!(sections_list)
    sections_list
  end

  @spec generate_json!(list(any)) :: list(any)
  defp generate_json!(sections_list) do
    JsonFileWriter.write!(sections_list)
    sections_list
  end
end
