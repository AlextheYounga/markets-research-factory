require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"
require "csv"

namespace :test do
  desc "Scrape all companies on the NSYE for their names"
  task :nyse => :environment do
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)
    # start = Time.now
    stocks = CSV.read("/Users/alexyounger/Desktop/Development/Rails/scraper/storage/NYSE.csv")

    stocks.each do |stock|
      begin
        ticker = stock.to_s
        company = StockQuote::Stock.company("#{ticker}")
        name = company.try(:company_name)

        puts "#{name} - #{ticker}"
      rescue => e
        puts ""
        # log exception or ignore it.
      end
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
