require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'

namespace :app do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :scrape_russell3000 => :environment do

    start = Time.now
    Rake::Task['db:seed'].invoke
    puts "DB reseeded to clear database"

    Stock.all.each do |stock|
      company = StockQuote::Stock.quote("#{stock.symbol}")

      Stock.where(symbol: "#{stock.symbol}").update(
        company_name: company.company_name,
        latest_price: company.latest_price,
        pe_ratio: company.pe_ratio,
        latest_time: company.latest_time
      )
      puts "#{stock.symbol} information collected"
    end

    finish = Time.now
    diff = finish - start
    puts "Done" 
    puts "Time Elapsed: #{diff}"
  end
end