require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'json'

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :lookup => :environment do
  StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)

    start = Time.now
    STOCKS = [
      'TLT',
      'SHY',
      'SPY',
      'IWM',
      'QQQ',
      'XLU',
      'VNQ',
      'XLP',
      'XLK',
      'VXX',
      'UUP',
      'MSFT',
      'AAPL',
      'AMZN',
      'FB',
      'GOOGL',
      'NFLX',
      'TSLA',
    ]

    STOCKS.each do |stock|      
      company = StockQuote::Stock.company("#{stock}")
      company_quote =  StockQuote::Stock.quote("#{stock}")
      stats = StockQuote::Stock.stats("#{stock}")

      
      next if company.nil? && company_quote.nil? && stats.nil?

      name = company.try(:company_name)
      price = company_quote.try(:latest_price)
      year5_change_percent = stats.try(:year5_change_percent)
      year2_change_percent = stats.try(:year2_change_percent)
      year1_change_percent = stats.try(:year1_change_percent)
      ytd_change_percent = stats.try(:ytd_change_percent)
      month6_change_percent = stats.try(:month6_change_percent)
      month3_change_percent = stats.try(:month3_change_percent)
      month1_change_percent = stats.try(:month1_change_percent)
      day30_change_percent = stats.try(:day30_change_percent)
      day5_change_percent = stats.try(:day5_change_percent)

      Stock.create([            
        company_name: name,
        ticker: stock,
        latest_price: price,
        year5_change_percent: year5_change_percent,
        year2_change_percent: year2_change_percent,
        year1_change_percent: year1_change_percent,
        ytd_change_percent: ytd_change_percent,
        month6_change_percent: month6_change_percent,
        month3_change_percent: month3_change_percent,
        month1_change_percent: month1_change_percent,
        day30_change_percent: day30_change_percent,
        day5_change_percent: day5_change_percent,
    ]);

      puts "#{name} - #{price}"
    end

    finish = Time.now
    diff = finish - start
    puts "Done" 
    puts "Time Elapsed: #{diff}"
  end
end