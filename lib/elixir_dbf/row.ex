defmodule ElixirDbf.Row do
  @moduledoc """
    ElixirDbf row module
  """

  def decode(string, :utf8), do: string
  def decode(string, encoding) when is_atom(encoding), do: Exconv.to_unicode!(string, encoding)
  def decode(string, [from, to]) do
    string
    |> Exconv.to_unicode!(from)
    |> Exconv.to_unicode!(to)
  end

  def read(stream, chars, encoding), do: stream |> IO.binread(chars) |> decode(encoding)

  def parse_column(_column, :eof), do: nil
  def parse_column(column, field) do
    case column.type do
      :string ->
        value = field |> String.trim_trailing(" ")
        {column.name, value}
      :numeric ->
        raw_string = field |> String.trim_leading(" ")
        value =
          case raw_string do
            "" -> nil
            _ ->
              case Integer.parse(raw_string) do
                {number, ""} -> number
                _ -> String.to_float(raw_string)
              end
          end
        {column.name, value}
      :integer ->
        value =
          case String.trim_leading(field, " ") do
            "" -> nil
            str_int ->
              integer_size = column.field_size * 8
              <<integer::little-integer-size(integer_size)>> = str_int
              integer
          end
        {column.name, value}
      :float ->
        value =
          case String.trim_leading(field, " ") do
            "" -> nil
            str_flt -> String.to_float(str_flt)
          end
        {column.name, value}
      :date ->
        value =
          case Timex.parse(field, "{YYYY}{0M}{D}") do
            {:ok, datetime} -> Timex.to_date(datetime)
            {:error, _} -> nil
          end
        {column.name, value}
      _ -> {column.name, column.type, field}
    end
  end

  def parse(stream, columns, encoding) do
    case read(stream, 1, encoding) do
      " " ->
        for column <- columns do
          field = read(stream, column.field_size, encoding)
          parse_column(column, field)
        end
      _ -> :error
    end
  end
end
