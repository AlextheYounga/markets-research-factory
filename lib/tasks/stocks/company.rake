
require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'json'

namespace :stocks do
    desc "Scrape all companies on the Russell 3000 for financial data"
    task :company => :environment do
        StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)

        start = Time.now
        Stock.all.each do |stock|
            next if stock.id < 359 

            ticker = stock.ticker.downcase

            company = StockQuote::Stock.company(ticker)
            quote = StockQuote::Stock.quote(ticker)
            price = quote.try(:latest_price)

            Stock.where(ticker: "#{stock.ticker}").update(
                company_name: company.try(:company_name),
                latest_price: price,
                description: company.try(:description),
                industry: company.try(:industry),
                primary_exchange: company.try(:exchange),
            )        
            puts "#{stock.ticker} - saved".green
        end

            finish = Time.now
            diff = finish - start
            puts "Done"
            puts "Time Elapsed: #{diff}"
    end
end