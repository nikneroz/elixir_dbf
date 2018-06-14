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
    "32" => "Visual FoxPro with field type Varchar or Varbinary",
    "43" => "dBASE IV SQL table files, no memo",
    "63" => "dBASE IV SQL system files, no memo",
    "7b" => "dBase IV with memo file",
    "83" => "dBase III with memo file",
    "87" => "Visual Objects 1.x with memo file",
    "8b" => "dBase IV with memo file",
    "8e" => "dBase IV with SQL table",
    "cb" => "dBASE IV SQL table files, with memo",
    "f5" => "FoxPro with memo file",
    "e5" => "HiPer-Six format with SMT memo file",
    "fb" => "FoxPro without memo file"
  }

  @encodings %{
    "01" => :cp437,       # U.S. MS-DOS
    "02" => :cp850,       # International MS-DOS
    "03" => :cp1252,      # Windows ANSI
    "08" => :cp865,       # Danish OEM
    "09" => :cp437,       # Dutch OEM
    "0a" => :cp850,       # Dutch OEM*
    "0b" => :cp437,       # Finnish OEM
    "0d" => :cp437,       # French OEM
    "0e" => :cp850,       # French OEM*
    "0f" => :cp437,       # German OEM
    "10" => :cp850,       # German OEM*
    "11" => :cp437,       # Italian OEM
    "12" => :cp850,       # Italian OEM*
    "13" => :cp932,       # Japanese Shift-JIS
    "14" => :cp850,       # Spanish OEM*
    "15" => :cp437,       # Swedish OEM
    "16" => :cp850,       # Swedish OEM*
    "17" => :cp865,       # Norwegian OEM
    "18" => :cp437,       # Spanish OEM
    "19" => :cp437,       # English OEM (Britain)
    "1a" => :cp850,       # English OEM (Britain)*
    "1b" => :cp437,       # English OEM (U.S.)
    "1c" => :cp863,       # French OEM (Canada)
    "1d" => :cp850,       # French OEM*
    "1f" => :cp852,       # Czech OEM
    "22" => :cp852,       # Hungarian OEM
    "23" => :cp852,       # Polish OEM
    "24" => :cp860,       # Portuguese OEM
    "25" => :cp850,       # Portuguese OEM*
    "26" => :cp866,       # Russian OEM
    "37" => :cp850,       # English OEM (U.S.)*
    "40" => :cp852,       # Romanian OEM
    "4d" => :cp936,       # Chinese GBK (PRC)
    "4e" => :cp949,       # Korean (ANSI/OEM)
    "4f" => :cp950,       # Chinese Big5 (Taiwan)
    "50" => :cp874,       # Thai (ANSI/OEM)
    "57" => :cp1252,      # ANSI
    "58" => :cp1252,      # Western European ANSI
    "59" => :cp1252,      # Spanish ANSI
    "64" => :cp852,       # Eastern European MS-DOS
    "65" => :cp866,       # Russian MS-DOS
    "66" => :cp865,       # Nordic MS-DOS
    "67" => :cp861,       # Icelandic MS-DOS
    "6a" => :cp737,       # Greek MS-DOS (437G)
    "6b" => :cp857,       # Turkish MS-DOS
    "6c" => :cp863,       # French-Canadian MS-DOS
    "78" => :cp950,       # Taiwan Big 5
    "79" => :cp949,       # Hangul (Wansung)
    "7a" => :cp936,       # PRC GBK
    "7b" => :cp932,       # Japanese Shift-JIS
    "7c" => :cp874,       # Thai Windows/MS-DOS
    "86" => :cp737,       # Greek OEM
    "87" => :cp852,       # Slovenian OEM
    "88" => :cp857,       # Turkish OEM
    "c8" => :cp1250,      # Eastern European Windows
    "c9" => :cp1251,      # Russian Windows
    "ca" => :cp1254,      # Turkish Windows
    "cb" => :cp1253,      # Greek Windows
    "cc" => :cp1257       # Baltic Windows
  }

  @column_flags %{
    "01" => "System Column (not visible to user)",
    "02" => "Column can store null values",
    "04" => "Binary column (for CHAR and MEMO only) ",
    "06" => "(0x02+0x04) When a field is NULL and binary (Integer, Currency, and Character/Memo fields)",
    "0C" => "Column is autoincrementing"
  }

  def get_version(version_byte) do
    hex = Base.encode16(version_byte)
    @versions[hex] || :unknown
  end

  def get_encoding(encoding_byte) do
    hex = Base.encode16(encoding_byte)
    @encodings[hex] || :utf8
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
      _reserved_zeros_2::binary-size(1),
      encoding_byte::binary-size(1)
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
      encoding: get_encoding(encoding_byte)
    }
  end

  def parse_columns(file, columns \\ []) do
    case IO.binread(file, 1) do
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
          field_flag::binary-size(1),
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
          # field_flag: detect_flag(field_flag),
          # next: next,
          # step: step
        }

        parse_columns(file, [column | columns])
    end
  end

  def detect_flag(field_flag_byte) do
    hex = Base.encode16(field_flag_byte)
    @column_flags[hex] || :default
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
