defmodule ElixirDbf.HeaderTest do
  use ExUnit.Case
  doctest ElixirDbf
  alias ElixirDbf.{Header, Table}

  test "cp1251" do
    Table.read("test/fixtures/goods.dbf") |> IO.inspect
  end

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
        %{name: "Max_PDOP", field_size: 5, type: :numeric},
        %{name: "Max_HDOP", field_size: 5, type: :numeric},
        %{name: "Corr_Type", field_size: 36, type: :string},
        %{name: "Rcvr_Type", field_size: 36, type: :string},
        %{name: "GPS_Date", field_size: 8, type: :date},
        %{name: "GPS_Time", field_size: 10, type: :string},
        %{name: "Update_Sta", field_size: 36, type: :string},
        %{name: "Feat_Name", field_size: 20, type: :string},
        %{name: "Datafile", field_size: 20, type: :string},
        %{name: "Unfilt_Pos", field_size: 10, type: :numeric},
        %{name: "Filt_Pos", field_size: 10, type: :numeric},
        %{name: "Data_Dicti", field_size: 20, type: :string},
        %{name: "GPS_Week", field_size: 6, type: :numeric},
        %{name: "GPS_Second", field_size: 12, type: :numeric},
        %{name: "GPS_Height", field_size: 16, type: :numeric},
        %{name: "Vert_Prec", field_size: 16, type: :numeric},
        %{name: "Horz_Prec", field_size: 16, type: :numeric},
        %{name: "Std_Dev", field_size: 16, type: :numeric},
        %{name: "Northing", field_size: 16, type: :numeric},
        %{name: "Easting", field_size: 16, type: :numeric},
        %{name: "Point_ID", field_size: 9, type: :numeric}
      ]
    }
  end

  test "dbase_30.dbf" do
    {:ok, file} = File.open("test/fixtures/dbase_30.dbf")
    header = Header.parse(file)

    assert header == %{
      date: 395_529,
      encryption_flag: 0,
      header_size: 4936,
      incomplete_transaction: 0,
      language_driver_id: 3,
      mdx_flag: 3,
      records: 34,
      record_size: 3907,
      version: 48,
      columns: [%{field_size: 15, name: "ACCESSNO", type: :string},
       %{field_size: 12, name: "ACQVALUE", type: :numeric},
       %{field_size: 4, name: "APPNOTES", type: :memo},
       %{field_size: 75, name: "APPRAISOR", type: :string},
       %{field_size: 25, name: "CABINET", type: :string},
       %{field_size: 30, name: "CAPTION", type: :string},
       %{field_size: 1, name: "CAT", type: :string},
       %{field_size: 25, name: "CATBY", type: :string},
       %{field_size: 8, name: "CATDATE", type: :date},
       %{field_size: 15, name: "CATTYPE", type: :string},
       %{field_size: 4, name: "CLASSES", type: :memo},
       %{field_size: 75, name: "COLLECTION", type: :string},
       %{field_size: 8, name: "CONDDATE", type: :date},
       %{field_size: 25, name: "CONDEXAM", type: :string},
       %{field_size: 35, name: "CONDITION", type: :string},
       %{field_size: 4, name: "CONDNOTES", type: :memo},
       %{field_size: 40, name: "CONTAINER", type: :string},
       %{field_size: 4, name: "COPYRIGHT", type: :memo},
       %{field_size: 80, name: "CREATOR", type: :string},
       %{field_size: 4, name: "CREDIT", type: :memo},
       %{field_size: 12, name: "CURVALMAX", type: :numeric},
       %{field_size: 12, name: "CURVALUE", type: :numeric},
       %{field_size: 15, name: "DATASET", type: :string},
       %{field_size: 50, name: "DATE", type: :string},
       %{field_size: 4, name: "DESCRIP", type: :memo},
       %{field_size: 4, name: "DIMNOTES", type: :memo},
       %{field_size: 10, name: "DISPVALUE", type: :string},
       %{field_size: 20, name: "DRAWER", type: :string},
       %{field_size: 4, name: "EARLYDATE", type: :numeric},
       %{field_size: 80, name: "EVENT", type: :string},
       %{field_size: 36, name: "EXHIBITID", type: :string},
       %{field_size: 7, name: "EXHIBITNO", type: :numeric},
       %{field_size: 4, name: "EXHLABEL1", type: :memo},
       %{field_size: 4, name: "EXHLABEL2", type: :memo},
       %{field_size: 4, name: "EXHLABEL3", type: :memo},
       %{field_size: 4, name: "EXHLABEL4", type: :memo},
       %{field_size: 8, name: "EXHSTART", type: :date},
       %{field_size: 35, name: "FILMSIZE", type: :string},
       %{field_size: 8, name: "FLAGDATE", type: :datetime},
       %{field_size: 4, name: "FLAGNOTES", type: :memo},
       %{field_size: 20, name: "FLAGREASON", type: :string},
       %{field_size: 75, name: "FRAME", type: :string},
       %{field_size: 25, name: "FRAMENO", type: :string},
       %{field_size: 45, name: "GPARENT", type: :string},
       %{field_size: 60, name: "HOMELOC", type: :string},
       %{field_size: 60, name: "IMAGEFILE", type: :string},
       %{field_size: 3, name: "IMAGENO", type: :numeric},
       %{field_size: 30, name: "INSCOMP", type: :string},
       %{field_size: 8, name: "INSDATE", type: :date},
       %{field_size: 25, name: "INSPHONE", type: :string},
       %{field_size: 20, name: "INSPREMIUM", type: :string},
       %{field_size: 30, name: "INSREP", type: :string},
       %{field_size: 10, name: "INSVALUE", type: :numeric},
       %{field_size: 25, name: "INVNBY", type: :string},
       %{field_size: 8, name: "INVNDATE", type: :date},
       %{field_size: 4, name: "LATEDATE", type: :numeric},
       %{field_size: 4, name: "LEGAL", type: :memo},
       %{field_size: 4, name: "LOANCOND", type: :memo},
       %{field_size: 8, name: "LOANDATE", type: :date},
       %{field_size: 8, name: "LOANDUE", type: :date},
       %{field_size: 36, name: "LOANID", type: :string},
       %{field_size: 15, name: "LOANINNO", type: :string},
       %{field_size: 10, name: "MAINTCYCLE", type: :string},
       %{field_size: 8, name: "MAINTDATE", type: :date},
       %{field_size: 4, name: "MAINTNOTE", type: :memo},
       %{field_size: 75, name: "MEDIUM", type: :string},
       %{field_size: 60, name: "NEGLOC", type: :string},
       %{field_size: 25, name: "NEGNO", type: :string},
       %{field_size: 4, name: "NOTES", type: :memo},
       %{field_size: 25, name: "OBJECTID", type: :string},
       %{field_size: 40, name: "OBJNAME", type: :string},
       %{field_size: 25, name: "OLDNO", type: :string},
       %{field_size: 15, name: "ORIGCOPY", type: :string},
       %{field_size: 25, name: "OTHERNO", type: :string},
       %{field_size: 8, name: "OUTDATE", type: :date},
       %{field_size: 40, name: "PARENT", type: :string},
       %{field_size: 4, name: "PEOPLE", type: :memo},
       %{field_size: 100, name: "PLACE", type: :string},
       %{field_size: 20, name: "POLICYNO", type: :string},
       %{field_size: 35, name: "PRINTSIZE", type: :string},
       %{field_size: 75, name: "PROCESS", type: :string},
       %{field_size: 4, name: "PROVENANCE", type: :memo},
       %{field_size: 4, name: "PUBNOTES", type: :memo},
       %{field_size: 20, name: "RECAS", type: :string},
       %{field_size: 10, name: "RECDATE", type: :string},
       %{field_size: 120, name: "RECFROM", type: :string},
       %{field_size: 36, name: "RELATION", type: :string},
       %{field_size: 4, name: "RELNOTES", type: :memo},
       %{field_size: 25, name: "ROOM", type: :string},
       %{field_size: 1, name: "SGFLAG", type: :string},
       %{field_size: 20, name: "SHELF", type: :string},
       %{field_size: 40, name: "SITE", type: :string},
       %{field_size: 12, name: "SITENO", type: :string},
       %{field_size: 25, name: "SLIDENO", type: :string},
       %{field_size: 20, name: "STATUS", type: :string},
       %{field_size: 25, name: "STATUSBY", type: :string},
       %{field_size: 8, name: "STATUSDATE", type: :date},
       %{field_size: 4, name: "STERMS", type: :memo},
       %{field_size: 60, name: "STUDIO", type: :string},
       %{field_size: 4, name: "SUBJECTS", type: :memo},
       %{field_size: 25, name: "TCABINET", type: :string},
       %{field_size: 40, name: "TCONTAINER", type: :string},
       %{field_size: 20, name: "TDRAWER", type: :string},
       %{field_size: 25, name: "TEMPAUTHOR", type: :string},
       %{field_size: 25, name: "TEMPBY", type: :string},
       %{field_size: 8, name: "TEMPDATE", type: :date},
       %{field_size: 60, name: "TEMPLOC", type: :string},
       %{field_size: 4, name: "TEMPNOTES", type: :memo},
       %{field_size: 50, name: "TEMPREASON", type: :string},
       %{field_size: 10, name: "TEMPUNTIL", type: :string},
       %{field_size: 4, name: "TITLE", type: :memo},
       %{field_size: 100, name: "TITLESORT", type: :string},
       %{field_size: 25, name: "TROOM", type: :string},
       %{field_size: 20, name: "TSHELF", type: :string},
       %{field_size: 20, name: "TWALL", type: :string},
       %{field_size: 75, name: "UDF1", type: :string},
       %{field_size: 75, name: "UDF10", type: :string},
       %{field_size: 20, name: "UDF11", type: :string},
       %{field_size: 20, name: "UDF12", type: :string},
       %{field_size: 12, name: "UDF13", type: :numeric},
       %{field_size: 12, name: "UDF14", type: :numeric},
       %{field_size: 12, name: "UDF15", type: :numeric},
       %{field_size: 12, name: "UDF16", type: :numeric},
       %{field_size: 12, name: "UDF17", type: :numeric},
       %{field_size: 8, name: "UDF18", type: :date},
       %{field_size: 8, name: "UDF19", type: :date},
       %{field_size: 8, name: "UDF20", type: :date},
       %{field_size: 4, name: "UDF21", type: :memo},
       %{field_size: 4, name: "UDF22", type: :memo},
       %{field_size: 75, name: "UDF2", type: :string},
       %{field_size: 75, name: "UDF3", type: :string},
       %{field_size: 75, name: "UDF4", type: :string},
       %{field_size: 75, name: "UDF5", type: :string},
       %{field_size: 75, name: "UDF6", type: :string},
       %{field_size: 75, name: "UDF7", type: :string},
       %{field_size: 75, name: "UDF8", type: :string},
       %{field_size: 75, name: "UDF9", type: :string},
       %{field_size: 8, name: "UPDATED", type: :datetime},
       %{field_size: 25, name: "UPDATEDBY", type: :string},
       %{field_size: 8, name: "VALUEDATE", type: :date},
       %{field_size: 20, name: "WALL", type: :string},
       %{field_size: 1, name: "WEBINCLUDE", type: :boolean},
       %{field_size: 69, name: "ZSORTER", type: :string},
       %{field_size: 44, name: "ZSORTERX", type: :string},
       %{field_size: 36, name: "PPID", type: :string}]
    }
  end

  test "dbase_31.dbf" do
    {:ok, file} = File.open("test/fixtures/dbase_31.dbf")
    header = Header.parse(file)
    assert header == %{
      date: 133122,
      encryption_flag: 0,
      header_size: 648,
      incomplete_transaction: 0,
      language_driver_id: 3,
      mdx_flag: 1,
      record_size: 95,
      records: 77,
      version: 49,
      columns: [
        %{field_size: 4, name: "PRODUCTID", type: :integer},
        %{field_size: 40, name: "PRODUCTNAM", type: :string},
        %{field_size: 4, name: "SUPPLIERID", type: :integer},
        %{field_size: 4, name: "CATEGORYID", type: :integer},
        %{field_size: 20, name: "QUANTITYPE", type: :string},
        %{field_size: 8, name: "UNITPRICE", type: :currency},
        %{field_size: 4, name: "UNITSINSTO", type: :integer},
        %{field_size: 4, name: "UNITSONORD", type: :integer},
        %{field_size: 4, name: "REORDERLEV", type: :integer},
        %{field_size: 1, name: "DISCONTINU", type: :boolean},
        %{field_size: 1, name: "_NullFlags", type: :null_flag}
      ]
    }
  end


  test "dbase_83.dbf" do
    {:ok, file} = File.open("test/fixtures/dbase_83.dbf")
    header = Header.parse(file)
    assert header == %{
      date: 6753298,
      encryption_flag: 0,
      header_size: 513,
      incomplete_transaction: 0,
      language_driver_id: 0,
      mdx_flag: 0,
      record_size: 805,
      records: 67,
      version: 131,
      columns: [
        %{field_size: 19, name: "ID", type: :numeric},
        %{field_size: 19, name: "CATCOUNT", type: :numeric},
        %{field_size: 19, name: "AGRPCOUNT", type: :numeric},
        %{field_size: 19, name: "PGRPCOUNT", type: :numeric},
        %{field_size: 19, name: "ORDER", type: :numeric},
        %{field_size: 50, name: "CODE", type: :string},
        %{field_size: 100, name: "NAME", type: :string},
        %{field_size: 254, name: "THUMBNAIL", type: :string},
        %{field_size: 254, name: "IMAGE", type: :string},
        %{field_size: 13, name: "PRICE", type: :numeric},
        %{field_size: 13, name: "COST", type: :numeric},
        %{field_size: 10, name: "DESC", type: :memo},
        %{field_size: 13, name: "WEIGHT", type: :numeric},
        %{field_size: 1, name: "TAXABLE", type: :boolean},
        %{field_size: 1, name: "ACTIVE", type: :boolean}
      ]
    }
  end

  test "dbase_8b.dbf" do
    {:ok, file} = File.open("test/fixtures/dbase_8b.dbf")
    header = Header.parse(file)
    assert header == %{
      date: 6555148,
      encryption_flag: 0,
      header_size: 225,
      incomplete_transaction: 0,
      language_driver_id: 0,
      mdx_flag: 0,
      record_size: 160,
      records: 10,
      version: 139,
      columns: [
        %{field_size: 100, name: "CHARACTER", type: :string},
        %{field_size: 20, name: "NUMERICAL", type: :numeric},
        %{field_size: 8, name: "DATE", type: :date},
        %{field_size: 1, name: "LOGICAL", type: :boolean},
        %{field_size: 20, name: "FLOAT", type: :float},
        %{field_size: 10, name: "MEMO", type: :memo}
      ]
    }
  end

  test "dbase_f5.dbf" do
    {:ok, file} = File.open("test/fixtures/dbase_f5.dbf")
    header = Header.parse(file)
    assert header == %{
      date: 262684,
      encryption_flag: 0,
      header_size: 1921,
      incomplete_transaction: 0,
      language_driver_id: 0,
      mdx_flag: 0,
      record_size: 969,
      records: 975,
      version: 245,
      columns: [
        %{field_size: 5, name: "NF", type: :numeric},
        %{field_size: 1, name: "SEXE", type: :string},
        %{field_size: 20, name: "NOM", type: :string},
        %{field_size: 15, name: "COG1", type: :string},
        %{field_size: 15, name: "COG2", type: :string},
        %{field_size: 9, name: "TELEFON", type: :string},
        %{field_size: 15, name: "RENOM", type: :string},
        %{field_size: 5, name: "NFP", type: :numeric},
        %{field_size: 5, name: "NFM", type: :numeric},
        %{field_size: 10, name: "ARXN", type: :string},
        %{field_size: 8, name: "DATN", type: :date},
        %{field_size: 15, name: "LLON", type: :string},
        %{field_size: 15, name: "MUNN", type: :string},
        %{field_size: 15, name: "COMN", type: :string},
        %{field_size: 15, name: "PROV", type: :string},
        %{field_size: 15, name: "PAIN", type: :string},
        %{field_size: 15, name: "OFIC", type: :string},
        %{field_size: 10, name: "ARXB", type: :string},
        %{field_size: 8, name: "DATB", type: :date},
        %{field_size: 15, name: "LLOB", type: :string},
        %{field_size: 15, name: "MUNB", type: :string},
        %{field_size: 15, name: "COMB", type: :string},
        %{field_size: 15, name: "PAIB", type: :string},
        %{field_size: 30, name: "DRIB", type: :string},
        %{field_size: 30, name: "INAB", type: :string},
        %{field_size: 10, name: "OFTB", type: :string},
        %{field_size: 20, name: "OFNB", type: :string},
        %{field_size: 10, name: "AXC1", type: :string},
        %{field_size: 8, name: "DTC1", type: :date},
        %{field_size: 15, name: "LLC1", type: :string},
        %{field_size: 5, name: "NFC1", type: :numeric},
        %{field_size: 10, name: "TCA1", type: :string},
        %{field_size: 10, name: "OTC1", type: :string},
        %{field_size: 20, name: "ONC1", type: :string},
        %{field_size: 10, name: "AXC2", type: :string},
        %{field_size: 8, name: "DTC2", type: :date},
        %{field_size: 15, name: "LLC2", type: :string},
        %{field_size: 5, name: "NFC2", type: :numeric},
        %{field_size: 10, name: "TCA2", type: :string},
        %{field_size: 10, name: "OTC2", type: :string},
        %{field_size: 20, name: "ONC2", type: :string},
        %{field_size: 10, name: "AXC3", type: :string},
        %{field_size: 8, name: "DTC3", type: :date},
        %{field_size: 15, name: "LLC3", type: :string},
        %{field_size: 5, name: "NFC3", type: :numeric},
        %{field_size: 10, name: "TCA3", type: :string},
        %{field_size: 10, name: "OTC3", type: :string},
        %{field_size: 20, name: "ONC3", type: :string},
        %{field_size: 10, name: "ARXD", type: :string},
        %{field_size: 8, name: "DATD", type: :date},
        %{field_size: 15, name: "LLOD", type: :string},
        %{field_size: 10, name: "OFTD", type: :string},
        %{field_size: 20, name: "OFND", type: :string},
        %{field_size: 70, name: "OBS1", type: :string},
        %{field_size: 70, name: "OBS2", type: :string},
        %{field_size: 70, name: "OBS3", type: :string},
        %{field_size: 70, name: "OBS4", type: :string},
        %{field_size: 10, name: "OBSE", type: :memo},
        %{field_size: 15, name: "GHD", type: :string}
      ]

    }
  end

  test 'foxprodb/calls.dbf' do
    {:ok, file} = File.open("test/fixtures/foxprodb/calls.dbf")
    header = Header.parse(file)
    assert header == %{
      columns: [
        %{field_size: 4, name: "CALL_ID", type: :integer},
        %{field_size: 4, name: "CONTACT_ID", type: :integer},
        %{field_size: 8, name: "CALL_DATE", type: :datetime},
        %{field_size: 8, name: "CALL_TIME", type: :datetime},
        %{field_size: 254, name: "SUBJECT", type: :string},
        %{field_size: 4, name: "NOTES", type: :memo}
      ],
      date: 984092,
      encryption_flag: 0,
      header_size: 488,
      incomplete_transaction: 0,
      language_driver_id: 3,
      mdx_flag: 3,
      record_size: 283,
      records: 16,
      version: 48
    }
  end


  test 'foxprodb/contacts.dbf' do
    {:ok, file} = File.open("test/fixtures/foxprodb/contacts.dbf")
    header = Header.parse(file)
    assert header == %{
      columns: [
        %{field_size: 4, name: "CONTACT_ID", type: :integer},
        %{field_size: 50, name: "FIRST_NAME", type: :string},
        %{field_size: 50, name: "LAST_NAME", type: :string},
        %{field_size: 50, name: "DEAR", type: :string},
        %{field_size: 254, name: "ADDRESS", type: :string},
        %{field_size: 50, name: "CITY", type: :string},
        %{field_size: 20, name: "STATE", type: :string},
        %{field_size: 20, name: "POSTALCODE", type: :string},
        %{field_size: 50, name: "REGION", type: :string},
        %{field_size: 50, name: "COUNTRY", type: :string},
        %{field_size: 50, name: "COMPANY_NA", type: :string},
        %{field_size: 50, name: "TITLE", type: :string},
        %{field_size: 30, name: "WORK_PHONE", type: :string},
        %{field_size: 20, name: "WORK_EXTEN", type: :string},
        %{field_size: 30, name: "HOME_PHONE", type: :string},
        %{field_size: 30, name: "MOBILE_PHO", type: :string},
        %{field_size: 30, name: "FAX_NUMBER", type: :string},
        %{field_size: 50, name: "EMAIL_NAME", type: :string},
        %{field_size: 8, name: "BIRTHDATE", type: :date},
        %{field_size: 8, name: "LAST_MEETI", type: :datetime},
        %{field_size: 4, name: "CONTACT_TY", type: :integer},
        %{field_size: 50, name: "REFERRED_B", type: :string},
        %{field_size: 4, name: "NOTES", type: :memo},
        %{field_size: 20, name: "MARITAL_ST", type: :string},
        %{field_size: 50, name: "SPOUSE_NAM", type: :string},
        %{field_size: 254, name: "SPOUSES_IN", type: :string},
        %{field_size: 254, name: "CHILDREN_N", type: :string},
        %{field_size: 50, name: "HOME_TOWN", type: :string},
        %{field_size: 254, name: "CONTACTS_I", type: :string}
      ],
      date: 984092,
      encryption_flag: 0,
      header_size: 1224,
      incomplete_transaction: 0,
      language_driver_id: 3,
      mdx_flag: 3,
      record_size: 1845,
      records: 5,
      version: 48
    }
  end


  test 'foxprodb/setup.dbf' do
    {:ok, file} = File.open("test/fixtures/foxprodb/setup.dbf")
    header = Header.parse(file)

    assert header == %{
      columns: [
        %{field_size: 50, name: "KEY_NAME", type: :string},
        %{field_size: 4, name: "VALUE", type: :integer}
      ],
      date: 984092,
      encryption_flag: 0,
      header_size: 360,
      incomplete_transaction: 0,
      language_driver_id: 3,
      mdx_flag: 1,
      record_size: 55,
      records: 3,
      version: 48
    }
  end


  test 'foxprodb/types.dbf' do
    {:ok, file} = File.open("test/fixtures/foxprodb/types.dbf")
    header = Header.parse(file)
    assert header == %{
      columns: [
        %{field_size: 4, name: "CONTACT_TY", type: :integer},
        %{field_size: 50, name: "CONTACT_T2", type: :string}
      ],
      date: 984092,
      encryption_flag: 0,
      header_size: 360,
      incomplete_transaction: 0,
      language_driver_id: 3,
      mdx_flag: 1,
      record_size: 55,
      records: 2,
      version: 48
    }
  end
end
