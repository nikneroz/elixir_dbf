defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  alias ElixirDbf.Header

  def new(path) do
    {:ok, file} = File.open(path)
    header = Header.parse(file)
  end

  # a10 x a x4 C2
end
