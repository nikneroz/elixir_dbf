defmodule ElixirDbf.Header do
  @moduledoc """
    ElixirDbf.Header module
  """

  @header_size 32

  @versions %{
    "02" => "FoxBase",
    "03" => "dBase III without memo file",
    "04" => "dBase IV without memo file",
    "05" => "dBase V without memo file",
    "07" => "Visual Objects 1.x",
    "30" => "Visual FoxPro",
    "31" => "Visual FoxPro with AutoIncrement field",
    "43" => "dBASE IV SQL table files, no memo",
    "63" => "dBASE IV SQL system files, no memo",
    "7b" => "dBase IV with memo file",
    "83" => "dBase III with memo file",
    "87" => "Visual Objects 1.x with memo file",
    "8b" => "dBase IV with memo file",
    "8e" => "dBase IV with SQL table",
    "cb" => "dBASE IV SQL table files, with memo",
    "f5" => "FoxPro with memo file",
    "fb" => "FoxPro without memo file"
  }

  def get_version(version_byte) do
    hex = Base.encode16(version_byte)
    @versions[hex] || :unknown
  end

  def parse(file) do
    raw_header = IO.binread(file, @header_size)
    <<
      version_byte::binary-size(1),
      date::size(24),
      records::little-integer-size(32),
      header_size::little-integer-size(16),
      record_size::little-integer-size(16),
      _reserved_zeros_1::size(16),
      incomplete_transaction::size(8),
      encryption_flag::size(8),
      _multi_user_processing::size(96),
      mdx_flag::size(8),
      language_driver_id::size(8),
      encoding::binary-size(2)
    >> = raw_header

    columns = parse_columns(file)

    current_cursor = @header_size + (@header_size * length(columns)) + 1
    header_remains = header_size - current_cursor
    IO.binread(file, header_remains)

    %{
      version: get_version(version_byte),
      date: date,
      records: records,
      header_size: header_size,
      record_size: record_size,
      incomplete_transaction: incomplete_transaction,
      encryption_flag: encryption_flag,
      mdx_flag: mdx_flag,
      language_driver_id: language_driver_id,
      columns: columns,
      # encoding: encoding
    }
  end

  def parse_columns(file, columns \\ []) do
    case IO.read(file, 1) do
      "\r" ->
        Enum.reverse(columns)

      start_byte ->
        field_block = start_byte <> IO.binread(file, @header_size - 1)
        <<
          name::binary-size(11),
          type::binary-size(1),
          _displacement::binary-size(4),
          field_size::integer-size(8),
          _decimal_places::binary-size(1),
          _field_flag::binary-size(1),
          _next::binary-size(4),
          _step::binary-size(1),
          _reserved::binary-size(8)
        >> = field_block

        column = %{
          name: String.trim_trailing(name, <<0>>),
          type: detect_type(type),
          # displacement: displacement,
          field_size: field_size,
          # decimal_places: decimal_places,
          # field_flag: field_flag,
          # next: next,
          # step: step
        }

        parse_columns(file, [column | columns])
    end
  end

  def detect_type(char) do
    case char do
      "C" -> :string # Character
      "Y" -> :currency # Currency
      "N" -> :numeric # Numeric
      "F" -> :float # Float
      "D" -> :date # Date
      "T" -> :datetime # DateTime
      "B" -> :float # Double
      "I" -> :integer # Integer
      "L" -> :boolean # Logical
      "M" -> :memo # Memo
      "G" -> :general # General
      "P" -> :picture # Picture
      "+" -> :autoincrement # Autoincrement (dBase Level 7)
      "O" -> :float # Double (dBase Level 7)
      "@" -> :datetime # Timestamp (dBase Level 7)
      "V" -> :string # Varchar type (Visual Foxpro)
      "0" -> :null_flag
    end
  end
end
