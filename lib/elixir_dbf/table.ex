defmodule ElixirDbf.Table do
  @moduledoc """
    ElixirDbf table module
  """

  @enforce_keys [:header, :rows]
  defstruct [:header, :rows]

  alias ElixirDbf.Header

  def read(path, encoding \\ nil) do
    case File.open(path) do
      {:error, reason} ->
        {:error, reason}
      {:ok, file} ->
        try do
          header = Header.parse(file)
          header_records_amount = header.records
          records_range = 1..header_records_amount

          rows =
            records_range
            |> Enum.map(fn _record_number ->
              row_block = IO.binread(file, header.record_size)
              ElixirDbf.Row.parse(row_block, header.columns, header.version, encoding || header.encoding)
            end)
            |> Enum.reject(&is_nil/1)

          case IO.binread(file, 1) do
            <<26>> -> :eof = IO.binread(file, 1)
            :eof -> :eof
          end

          {:ok, %__MODULE__{rows: rows, header: header}}
        after
          File.close(file)
        end
    end
  end
end
