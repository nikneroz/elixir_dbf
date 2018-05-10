defmodule ElixirDbf.Header do
  @moduledoc """
    ElixirDbf.Header module
  """

  @header_size 32

  def parse(file) do
    raw_header = IO.read(file, @header_size)
    <<
      version::size(8),
      date::size(24),
      records::little-integer-size(32),
      header_size::little-integer-size(16),
      records_size::little-integer-size(16),
      _reserved_zeros_1::size(16),
      incomplete_transaction::size(8),
      encryption_flag::size(8),
      _multi_user_processing::size(96),
      mdx_flag::size(8),
      language_driver_id::size(8),
      _reserved_zeros_2::size(16)
    >> = raw_header

    %{
      version: version,
      date: date,
      records: records,
      header_size: header_size,
      records_size: records_size,
      incomplete_transaction: incomplete_transaction,
      encryption_flag: encryption_flag,
      mdx_flag: mdx_flag,
      language_driver_id: language_driver_id,
    }
  end
end
