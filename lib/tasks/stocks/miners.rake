require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"
require "csv"

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :miners => :environment do
    start = Time.now
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)

    file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/stocks/Miners.csv"
    miners = CSV.parse(File.read(file, encoding: "bom|utf-8"))

    CSV.open("/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/lib/assets/minerBasicData.csv", "wb") do |csv|
      csv << ["Name", "Ticker", "Price", "Market Cap", "Country", "Shares Outstanding", "5 Day Change", "1 Month Change", "3 Month Change", "YTD Change" ]

      miners.each do |miner|
        company = StockQuote::Stock.company("#{miner}")
        quote = StockQuote::Stock.quote("#{miner}")
        keyStats = StockQuote::Stock.stats("#{miner}")

        next if company.nil? && quote.nil? && keyStats.nil?
            name = company.try(:company_name)
            price = quote.try(:latest_price)
            country = company.try(:country)
            marketCap = keyStats.try(:marketcap)
            sharesOutstanding = keyStats.try(:shares_outstanding)
            ytd_change_percent = keyStats.try(:ytd_change_percent)
            month3_change_percent = keyStats.try(:month3_change_percent)
            month1_change_percent = keyStats.try(:month1_change_percent)
            day5_change_percent = keyStats.try(:day5_change_percent)

        csv << [name, miner[0], price, marketCap, country, sharesOutstanding, day5_change_percent, month1_change_percent, month3_change_percent, ytd_change_percent]
        puts "#{miner[0]} saved"
      end
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
