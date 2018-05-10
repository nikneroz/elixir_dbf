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
      records_size: 590,
      version: 3,
      columns: [
        %{field_name: "Point_ID", field_type: :string},
        %{field_name: "Type", field_type: :string},
        %{field_name: "Shape", field_type: :string},
        %{field_name: "Circular_D", field_type: :string},
        %{field_name: "Non_circul", field_type: :string},
        %{field_name: "Flow_prese", field_type: :string},
        %{field_name: "Condition", field_type: :string},
        %{field_name: "Comments", field_type: :string},
        %{field_name: "Date_Visit", field_type: :date},
        %{field_name: "Time", field_type: :string},
        %{field_name: "Max_PDOP", field_type: :integer},
        %{field_name: "Max_HDOP", field_type: :integer},
        %{field_name: "Corr_Type", field_type: :string},
        %{field_name: "Rcvr_Type", field_type: :string},
        %{field_name: "GPS_Date", field_type: :date},
        %{field_name: "GPS_Time", field_type: :string},
        %{field_name: "Update_Sta", field_type: :string},
        %{field_name: "Feat_Name", field_type: :string},
        %{field_name: "Datafile", field_type: :string},
        %{field_name: "Unfilt_Pos", field_type: :integer},
        %{field_name: "Filt_Pos", field_type: :integer},
        %{field_name: "Data_Dicti", field_type: :string},
        %{field_name: "GPS_Week", field_type: :integer},
        %{field_name: "GPS_Second", field_type: :integer},
        %{field_name: "GPS_Height", field_type: :integer},
        %{field_name: "Vert_Prec", field_type: :integer},
        %{field_name: "Horz_Prec", field_type: :integer},
        %{field_name: "Std_Dev", field_type: :integer},
        %{field_name: "Northing", field_type: :integer},
        %{field_name: "Easting", field_type: :integer},
        %{field_name: "Point_ID", field_type: :integer}
      ]
    }
  end
end
