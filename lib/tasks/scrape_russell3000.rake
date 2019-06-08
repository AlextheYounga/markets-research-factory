require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'json'

namespace :app do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :scrape_russell3000 => :environment do

    start = Time.now

    Stock.all.each do |stock|
      company = StockQuote::Stock.company("#{stock.symbol}")
      company_quote =  StockQuote::Stock.quote("#{stock.symbol}")
      company_finance =  StockQuote::Stock.financials("#{stock.symbol}")
      
      next if company.nil? && company_quote.nil? && company_finance.nil?

      Stock.where(symbol: "#{stock.symbol}").update(
        company_name: company.try(:company_name),
        latest_price: company_quote.try(:latest_price),
        gross_profit: company_finance.financials ? company_finance.financials[0]["grossProfit"] : nil,
        net_income: company_finance.financials ? company_finance.financials[0]["netIncome"] : nil,
        total_assets: company_finance.financials ? company_finance.financials[0]["totalAssets"] : nil,
        total_liabilities: company_finance.financials ? company_finance.financials[0]["totalLiabilities"] : nil,
        total_debt: company_finance.financials ? company_finance.financials[0]["totalDebt"] : nil,
        pe_ratio: company_quote.try(:pe_ratio),
        industry: company.try(:industry),
        description: company.try(:description),
        primary_exchange: company_quote.primary_exchange,
        latest_time: company.try(:latest_time)
        
      )
      puts "#{stock.symbol} information collected"
    end

    finish = Time.now
    diff = finish - start
    puts "Done" 
    puts "Time Elapsed: #{diff}"
  end
end