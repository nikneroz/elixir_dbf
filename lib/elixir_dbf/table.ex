defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  alias ElixirDbf.Header

  def read(path) do
    {:ok, file} = File.open(path)
    header = Header.parse(file)
    rows =
      for _row_index <- 1..header.records do
        row_block = IO.read(file, header.record_size)
        ElixirDbf.Row.parse(row_block, header.columns, header.version)
      end
    with <<26>> <- IO.read(file, 1),
         :eof <- IO.read(file, 1)
    do
      rows
    else
      _e ->
        :error
    end
  end

  # a10 x a x4 C2
end
