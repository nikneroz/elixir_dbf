# ElixirDbf

[![Hex pm](https://img.shields.io/hexpm/v/elixir_dbf.svg?style=flat)](https://hex.pm/packages/elixir_dbf)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Downloads](https://img.shields.io/hexpm/dt/elixir_dbf)](https://hex.pm/packages/elixir_dbf)

Small library for DBF parsing written in pure elixir

```elixir
  {:ok, rows} = ElixirDbf.Table.read("test/fixtures/cp1251.dbf", :cp1251)
  {:ok,
   %ElixirDbf.Table{
     header: %{
       columns: [
         %{field_size: 4, name: "RN", type: :numeric},
         %{field_size: 100, name: "NAME", type: :string}
       ],
       date: 199175,
       encoding: :utf8,
       encryption_flag: 0,
       header_size: 360,
       incomplete_transaction: 0,
       language_driver_id: 201,
       mdx_flag: 1,
       record_size: 105,
       records: 4,
       version: "Visual FoxPro"
     },
     rows: [
       [{"RN", 1}, {"NAME", ""}],
       [{"RN", 2}, {"NAME", ""}],
       [{"RN", 3}, {"NAME", ""}],
       [{"RN", 4}, {"NAME", ""}]
     ]
   }}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_dbf` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_dbf, "~> 0.1.10"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_dbf](https://hexdocs.pm/elixir_dbf).

