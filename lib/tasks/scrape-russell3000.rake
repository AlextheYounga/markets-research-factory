require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'json'

namespace :app do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :scrape_russell3000 => :environment do

    start = Time.now

    unless Country
      Rake::Task["db:seed"].invoke
    end
    puts "Russell3000Table reseeded to clear database"

    Stock.all.each do |stock|
      company = StockQuote::Stock.company("#{stock.symbol}")
      company_quote = StockQuote::Stock.quote("#{stock.symbol}")
      company_finance = StockQuote::Stock.raw_financials("#{stock.symbol}").to_s

      Stock.where(symbol: "#{stock.symbol}").update(
        company_name: company.company_name,
        latest_price: company.latest_price,
        gross_profit: JSON.parse(company_finance)['grossProfit'].to_s,
        net_income: JSON.parse(company_finance)['net_income'].to_s,
        total_assets: JSON.parse(company_finance)['totalAssets'].to_s,
        total_liabilities: JSON.parse(company_finance)['totalLiabilities'].to_s,
        total_debt: JSON.parse(company_finance)['totalDebt'].to_s,
        pe_ratio: company_quote.pe_ratio,
        industry: company.industry,
        description: company.description,
        primary_exchange: company_quote.primary_exchange,
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