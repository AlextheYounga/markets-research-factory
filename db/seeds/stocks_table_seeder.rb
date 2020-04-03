
require "csv"

Stock.destroy_all
file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/stocks/NYSE.csv"
stocks = CSV.parse(File.read(file, encoding: 'bom|utf-8'))

stocks.each do |stock|
    name = stock.last
    ticker = stock.first

    Stock.create([
        company_name: name,
        ticker: ticker,
    ])
    puts "#{stock.last} saved".green
end
