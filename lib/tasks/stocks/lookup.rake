require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :lookup => :environment do
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)

    start = Time.now
    STOCKS = [
      "TLT",
      "SHY",
    #   "SPY",
    #   "IWM",
    #   "QQQ",
    #   "XLU",
    #   "VNQ",
    #   "XLP",
    #   "XLK",
    #   "VXX",
    #   "UUP",
    #   "MSFT",
    #   "AAPL",
    #   "AMZN",
    #   "FB",
    #   "GOOGL",
    #   "NFLX",
    #   "TSLA",
    ]

    output_file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/lib/assets/Lookup.csv"
    File.delete(output_file) if File.exist?(output_file)

    CSV.open(output_file, "wb") do |csv|
      csv << [
        "name",
        "price",
        "year5ChangePercent",
        "year2ChangePercent",
        "year1ChangePercent",
        "ytdChangePercent",
        "month6ChangePercent",
        "month3ChangePercent",
        "month1ChangePercent",
        "day30ChangePercent",
        "day5ChangePercent",
      ]

      STOCKS.each do |stock|
        begin
          company = StockQuote::Stock.company("#{stock}")
          company_quote = StockQuote::Stock.quote("#{stock}")
          stats = StockQuote::Stock.stats("#{stock}")

          next if company.nil? && company_quote.nil? && stats.nil?
          name = company.try(:company_name)
          price = company_quote.try(:latest_price)
          
          csv << [
            name,
            price,
            stats.try(:year5_change_percent),
            stats.try(:year2_change_percent),
            stats.try(:year1_change_percent),
            stats.try(:ytd_change_percent),
            stats.try(:month6_change_percent),
            stats.try(:month3_change_percent),
            stats.try(:month1_change_percent),
            stats.try(:day30_change_percent),
            stats.try(:day5_change_percent),
          ]
          puts "#{name} - #{price}"
        rescue => e
          puts "#{stock} - Error - #{e}"
        end
      end
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
