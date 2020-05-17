
require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"

namespace :stocks do
  desc "Lookup stock company information"
  task :company => :environment do
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)

    start = Time.now
    STOCK = [
      "SPXC",
      "DIA",
    ]
    output_file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/lib/assets/Company.csv"
    File.delete(output_file) if File.exist?(output_file)

    CSV.open(output_file, "wb") do |csv|
        csv << [
            "companyName",
            "latestPrice",
            "description",
            "industry",
            "primaryExchange",
        ]

        STOCK.each do |stock|
            begin
                company = StockQuote::Stock.company(stock)
                quote = StockQuote::Stock.quote(stock)
                price = quote.try(:latest_price)

                csv << [
                    company.try(:company_name),
                    price,
                    company.try(:description),
                    company.try(:industry),
                    company.try(:exchange),
                ]
                puts "#{stock} - saved".green
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
