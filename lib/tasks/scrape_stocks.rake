require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'json'

namespace :app do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :scrape_stocks => :environment do

    start = Time.now

    Stock.all.each do |stock|
      company = StockQuote::Stock.company("#{stock.symbol}")
      company_quote =  StockQuote::Stock.quote("#{stock.symbol}")
      company_finance =  StockQuote::Stock.financials("#{stock.symbol}")
      
      next if company.nil? && company_quote.nil? && company_finance.nil?

      a = company_finance.financials ? company_finance.financials[0]["netIncome"].to_f : nil
      b = company_finance.financials ? company_finance.financials[1]["netIncome"].to_f : nil
      c = company_finance.financials ? company_finance.financials[2]["netIncome"].to_f : nil
      d = company_finance.financials ? company_finance.financials[3]["netIncome"].to_f : nil

      e = (b - a) / (a) * 100 unless a.nil? || b.nil? 
      f = (c - b) / (b) * 100 unless b.nil? || c.nil? 
      g = (d - c) / (c) * 100 unless c.nil? || d.nil?

      moving_average = (e + f + g) / 3 unless a.nil? || b.nil? || c.nil? || d.nil?

      Stock.where(symbol: "#{stock.symbol}").update(
        company_name: company.try(:company_name),
        latest_price: company_quote.try(:latest_price),
        moving_average: moving_average ? (sprintf "%.2f", moving_average) : nil,
        gross_profit: company_finance.financials ? company_finance.financials[0]["grossProfit"] : nil,
        net_income: a,
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