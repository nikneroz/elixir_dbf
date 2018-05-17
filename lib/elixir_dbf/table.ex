defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  alias ElixirDbf.Header

  def read(path, encoding \\ :utf8) do
    {:ok, file} = File.open(path)
    header = Header.parse(file)

    rows =
      for _row_index <- 1..header.records do
        row_block = IO.binread(file, header.record_size)
        ElixirDbf.Row.parse(row_block, header.columns, header.version, encoding)
      end

    case IO.binread(file, 1) do
      <<26>> -> :eof = IO.binread(file, 1)
      :eof -> :eof
    end

    records_amount = header[:records]

    with ^records_amount <- length(rows) do
      {:ok, rows}
    else
      e -> e
    end
  end

  # a10 x a x4 C2
end
