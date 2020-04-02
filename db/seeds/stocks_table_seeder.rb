
require "csv"

Stock.destroy_all

stocks = CSV.read("/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/stocks/S&P500.csv")
stocks.each do |stock|
    Stock.create([            
        company_name: stock.last,
        symbol: stock.first,          
    ]);
    puts "#{stock.last} saved".green
end


