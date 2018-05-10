defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  def new(path) do
    file = File.open(path)
    header = Header.parse(file)
  end
end
