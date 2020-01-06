defmodule Mix.Tasks.Generate do
  use Mix.Task

  @shortdoc "Generate the website."
  def run(_) do
    HtmlFileWriter.write!()
  end
end
