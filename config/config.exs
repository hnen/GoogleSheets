# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :google_sheets, spreadsheets: [
  config: [
    sheets: ["KeyValue"],
    parser: nil,
    loader: GoogleSheets.Loader.Docs,
    poll_delay_seconds: 0,
    dir: "priv/data",
    url: "https://spreadsheets.google.com/feeds/worksheets/1k-N20RmT62RyocEu4-MIJm11DZqlZrzV89fGIddDzIs/public/basic"
  ],
  multiple: [
    sheets: ["KeyValue", "KeyTable"],
    parser: nil,
    loader: GoogleSheets.Loader.Docs,
    poll_delay_seconds: 0,
    dir: "priv/data",
    url: "https://spreadsheets.google.com/feeds/worksheets/1k-N20RmT62RyocEu4-MIJm11DZqlZrzV89fGIddDzIs/public/basic"
  ]
]

if Mix.env == :dev do
  config :ex_doc, :markdown_processor, ExDoc.Markdown.Pandoc
end
