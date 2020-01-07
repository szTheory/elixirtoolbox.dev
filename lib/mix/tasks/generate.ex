defmodule Mix.Tasks.Generate do
  use Mix.Task

  @shortdoc "Generate the website."
  def run(_) do
    # html
    Markdown.Sections.list()
    |> HtmlFileWriter.write!()

    # json
    Markdown.Sections.list()
    |> JsonFileWriter.write!()

    IO.puts("DONE: Generated index.html and index.json")
  end
end
