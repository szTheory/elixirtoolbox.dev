defmodule ReadmeDownloader do
  @moduledoc """
  Download the README file from Github
  """

  @readme_github_base_url "https://raw.githubusercontent.com/"
  @readme_github_path "szTheory/beamtoolbox/master/README.md"

  use Tesla
  plug(Tesla.Middleware.BaseUrl, @readme_github_base_url)

  def download() do
    {:ok, response} = get(@readme_github_path)
    response.body
  end
end
