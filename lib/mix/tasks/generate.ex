defmodule Mix.Tasks.Generate do
  use Mix.Task

  @shortdoc "Generate the website."
  def run(_) do
    Markdown.Sections.list()
    |> HtmlFileWriter.write!()
    |> JsonFileWriter.write!()

    IO.puts("DONE: Generated index.html and index.json")
  end
end
