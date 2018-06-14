defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  @enforce_keys [:header, :rows]
  defstruct [:header, :rows]

  alias ElixirDbf.Header

  def read(path, encoding \\ nil) do
    case File.binread(path) do
      {:error, reason} ->
        {:error, reason}
      {:ok, content} ->
        {:ok, file} = StringIO.open(content)
        header = Header.parse(file)

        rows =
          for _row_index <- 1..header.records do
            row_block = IO.binread(file, header.record_size)
            ElixirDbf.Row.parse(row_block, header.columns, header.version, encoding || header.encoding)
          end

        case IO.binread(file, 1) do
          <<26>> -> :eof = IO.binread(file, 1)
          :eof -> :eof
        end

        records_amount = header[:records]

        with ^records_amount <- length(rows) do
          {:ok, %__MODULE__{rows: rows, header: header}}
        else
          e -> e
        end
    end
  end
end
