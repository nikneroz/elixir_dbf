defmodule ElixirDbf.Row do
  @moduledoc """
    ElixirDbf row module
  """

  def parse(block, columns, version) do
    {:ok, stream} = StringIO.open(block)
    case IO.read(stream, 1) do
      " " ->
        for column <- columns do
          field = IO.read(stream, column.field_size)
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
              value = field |> String.trim_leading(" ") |> String.to_integer
              {column.name, value}
            :float ->
              value = field |> String.trim_leading(" ") |> String.to_float
              {column.name, value}
            :date ->
              value = field |> Timex.parse!("{YYYY}{0M}{D}") |> Timex.to_date
              {column.name, value}
            _ -> {column.name, column.type, field}
          end
        end
      x ->
        #IO.inspect(x)
        :error
    end
  end
end
