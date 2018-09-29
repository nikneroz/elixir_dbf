defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  @empty_stream {"", ""}

  @enforce_keys [:header, :rows]
  defstruct [:header, :rows]

  alias ElixirDbf.Header

  def parse_row({:ok, stream}, columns, encoding) do
    ElixirDbf.Row.parse(stream, columns, encoding)
  after
    {:ok, @empty_stream} = StringIO.close(stream)
  end
  def parse_row(block, columns, encoding) do
    block
    |> StringIO.open()
    |> parse_row(columns, encoding)
  end

  def read_rows(file, header, encoding, prev_block, rows \\ [])
  def read_rows(_file, _header, _encoding, :eof, rows), do: Enum.reverse(rows)
  def read_rows(_file, _header, _encoding, <<26>>, rows), do: Enum.reverse(rows)
  def read_rows(file, header, encoding, :start, rows) do
    next_block = IO.binread(file, header.record_size)
    read_rows(file, header, encoding, next_block, rows)
  end
  def read_rows(file, header, encoding, prev_block, rows) do
    row = parse_row(prev_block, header.columns, encoding || header.encoding)
    next_block = IO.binread(file, header.record_size)
    read_rows(file, header, encoding, next_block, [row | rows])
  end

  def fetch_data(file, encoding) do
    header = Header.parse(file)
    rows = read_rows(file, header, encoding, :start)
    data = %__MODULE__{rows: rows, header: header}

    if length(rows) == header.records do
      {:ok, data}
    else
      {:error, :damaged, data}
    end
  after
    :ok = File.close(file)
  end

  def read(path, encoding \\ nil) do
    case File.open(path) do
      {:error, reason} ->
        {:error, reason}
      {:ok, file} ->
        fetch_data(file, encoding)
    end
  end
end
