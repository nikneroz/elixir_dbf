defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  @enforce_keys [:header, :rows]
  defstruct [:header, :rows]

  alias ElixirDbf.Header

  def read_rows(file, header, encoding, prev_block, rows \\ [])
  def read_rows(_file, _header, _encoding, :eof, rows), do: Enum.reverse(rows)
  def read_rows(file, header, encoding, :start, rows) do
    next_block = IO.binread(file, header.record_size)
    read_rows(file, header, encoding, next_block, rows)
  end
  def read_rows(file, header, encoding, prev_block, rows) do
    row = ElixirDbf.Row.parse(prev_block, header.columns, header.version, encoding || header.encoding)
    next_block = IO.binread(file, header.record_size)
    read_rows(file, header, encoding, next_block, [row | rows])
  end

  def read(path, encoding \\ nil) do
    case File.open(path) do
      {:error, reason} ->
        {:error, reason}
      {:ok, file} ->
        try do
          header = Header.parse(file)
          rows = read_rows(file, header, encoding, :start)
          data = %__MODULE__{rows: rows, header: header}

          if length(rows) == header.records do
            {:ok, data}
          else
            {:error, :damaged, data}
          end
        after
          File.close(file)
        end
    end
  end
end
