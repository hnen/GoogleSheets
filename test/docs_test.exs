defmodule DocsTest do
  use ExUnit.Case, async: true

  require Logger

  alias GoogleSheets.Loader.Docs

  @url "https://spreadsheets.google.com/feeds/worksheets/1k-N20RmT62RyocEu4-MIJm11DZqlZrzV89fGIddDzIs/public/basic"
  @url2 "https://spreadsheets.google.com/feeds/worksheets/1P6KGe8ajcSNxk6oAWvXyPw4XcicKe2gex8p7lKz-uXU/public/basic"

  test "Fetch all sheets from one document" do
    config = [url: @url]
    assert {:ok, version, worksheets} = Docs.load nil, :spreadsheet_id, config

    assert version == "a3d4c20066a7f5ebebde18fc4f7ad1ecd6cb96ac"
    assert length(worksheets) == 4
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyValue" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyTable" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyIndexTable" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "Ignored" end)

    assert {:ok, :unchanged} = Docs.load version, :spreadsheet_id, config
  end

  test "Fetch all sheets from multiple documents" do
    config = [url: [@url, @url2]]
    assert {:ok, version, worksheets} = Docs.load nil, :spreadsheet_id, config

    #assert version == "a3d4c20066a7f5ebebde18fc4f7ad1ecd6cb96ac"
    assert length(worksheets) == 5
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyValue" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyTable" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyIndexTable" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "Ignored" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "Table2" end)

    assert {:ok, :unchanged} = Docs.load version, :spreadsheet_id, config
  end

  test "Load specific sheets" do
    config = [url: @url, sheets: ["KeyValue", "KeyTable", "Ignored"], ignored_sheets: ["Ignored"]]
    assert {:ok, version, worksheets} = Docs.load nil, :spreadsheet_id, config

    assert version == "eeb80c2fe8872b3e6b0ea13f7fa4125228c1da48"
    assert length(worksheets) == 2
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyValue" end)
    assert Enum.any?(worksheets, fn(x) -> x.name == "KeyTable" end)
    refute Enum.any?(worksheets, fn(x) -> x.name == "KeyIndexTable" end)
    refute Enum.any?(worksheets, fn(x) -> x.name == "Ignored" end)

    assert {:ok, :unchanged} = Docs.load version, :spreadsheet_id, config
  end

  test "fetch invalid url" do
    assert_raise MatchError, fn -> Docs.load nil, :spreadsheet_id, [url: "http://www.example.org/invalid_key"] end
  end

  test "Test non existent sheet" do
    assert {:error, _reason} = Docs.load nil, :spreadsheet_id, [url: @url, sheets: ["KeyValue", "NonExistingSheet"]]
  end

end
