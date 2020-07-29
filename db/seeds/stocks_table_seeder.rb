
require "csv"

Stock.destroy_all
file = "#{Rails.root}/storage/stocks/S&P500.csv"
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
