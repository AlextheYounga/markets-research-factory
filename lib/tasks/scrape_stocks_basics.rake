require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'json'

namespace :app do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :scrape_stocks_basics => :environment do
  StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)

    start = Time.now
    STOCKS = [
      'T',
      'VZ',
      'JNJ',
      'KO',
      'PEP',
      'CVS',
      'TGT',
      'DEO',
      'STZ',
      'PG',
      'HEINY',
    ]

    STOCKS.each do |stock|      
      company = StockQuote::Stock.company("#{stock}")
      company_quote =  StockQuote::Stock.quote("#{stock}")      
      
      next if company.nil? && company_quote.nil? && company_finance.nil?

      name = company.try(:company_name),
      price = company_quote.try(:latest_price)

      puts "#{name} - #{stock} - #{price}"
    end

    finish = Time.now
    diff = finish - start
    puts "Done" 
    puts "Time Elapsed: #{diff}"
  end
end