defmodule ElixirDbf.HeaderTest do
  use ExUnit.Case
  doctest ElixirDbf
  alias ElixirDbf.Header

  test "greets the world" do
    {:ok, file} = File.open("test/fixtures/dbase_03.dbf")
    header = Header.parse(file)
    assert header == %{
      date: 329_485,
      encryption_flag: 0,
      header_size: 1025,
      incomplete_transaction: 0,
      language_driver_id: 0,
      mdx_flag: 0,
      records: 14,
      record_size: 590,
      version: 3,
      columns: [
        %{name: "Point_ID", field_size: 12, type: :string},
        %{name: "Type", field_size: 20, type: :string},
        %{name: "Shape", field_size: 20, type: :string},
        %{name: "Circular_D", field_size: 20, type: :string},
        %{name: "Non_circul", field_size: 60, type: :string},
        %{name: "Flow_prese", field_size: 20, type: :string},
        %{name: "Condition", field_size: 20, type: :string},
        %{name: "Comments", field_size: 60, type: :string},
        %{name: "Date_Visit", field_size: 8, type: :date},
        %{name: "Time", field_size: 10, type: :string},
        %{name: "Max_PDOP", field_size: 5, type: :integer},
        %{name: "Max_HDOP", field_size: 5, type: :integer},
        %{name: "Corr_Type", field_size: 36, type: :string},
        %{name: "Rcvr_Type", field_size: 36, type: :string},
        %{name: "GPS_Date", field_size: 8, type: :date},
        %{name: "GPS_Time", field_size: 10, type: :string},
        %{name: "Update_Sta", field_size: 36, type: :string},
        %{name: "Feat_Name", field_size: 20, type: :string},
        %{name: "Datafile", field_size: 20, type: :string},
        %{name: "Unfilt_Pos", field_size: 10, type: :integer},
        %{name: "Filt_Pos", field_size: 10, type: :integer},
        %{name: "Data_Dicti", field_size: 20, type: :string},
        %{name: "GPS_Week", field_size: 6, type: :integer},
        %{name: "GPS_Second", field_size: 12, type: :integer},
        %{name: "GPS_Height", field_size: 16, type: :integer},
        %{name: "Vert_Prec", field_size: 16, type: :integer},
        %{name: "Horz_Prec", field_size: 16, type: :integer},
        %{name: "Std_Dev", field_size: 16, type: :integer},
        %{name: "Northing", field_size: 16, type: :integer},
        %{name: "Easting", field_size: 16, type: :integer},
        %{name: "Point_ID", field_size: 9, type: :integer}
      ]
    }
  end
end
