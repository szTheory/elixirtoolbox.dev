defmodule WebsiteTest do
  use ExUnit.Case
  doctest Website

  test "greets the world" do
    assert Website.hello() == :world
  end
end
