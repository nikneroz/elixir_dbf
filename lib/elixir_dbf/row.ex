defmodule ElixirDbf.Row do
  @moduledoc """
    ElixirDbf row module
  """

  def decode(string, :utf8), do: string
  def decode(string, encoding), do: :erlyconv.to_unicode(encoding, string)

  def read(stream, chars, encoding), do: stream |> IO.binread(chars) |> decode(encoding)

  def parse(block, columns, version, encoding) do
    {:ok, stream} = StringIO.open(block)
    case read(stream, 1, encoding) do
      " " ->
        for column <- columns do
          field = read(stream, column.field_size, encoding)
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
                  str_int -> String.to_integer(str_int)
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
      x ->
        :error
    end
  end
end
