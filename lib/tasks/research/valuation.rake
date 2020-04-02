require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :valuation => :environment do
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_hazlitt_key)

    start = Time.now
    Stock.all.each do |stock|
      url = "https://cloud.iexapis.com/v1/stock/#{stock.symbol}/advanced-stats?token=#{Rails.application.credentials.iex_hazlitt_key}"
      advanced_stats = JSON[open(url).read]
      quote =  StockQuote::Stock.quote("#{stock.symbol}")

      price = quote.try(:latest_price)
      companyName = advanced_stats["companyName"]
      peRatio = advanced_stats["peRatio"]
      ebitda = advanced_stats["EBITDA"]
      profitMargin = advanced_stats["profitMargin"]
      enterpriseValueToRevenue = advanced_stats["enterpriseValueToRevenue"]
      priceToSales = advanced_stats["priceToSales"]
      grossProfit = advanced_stats["grossProfit"]
      revenue = advanced_stats["revenue"]

      Stock.where(symbol: "#{stock.symbol}").update(
        company_name: companyName,
        latest_price: price.to_f,
        pe_ratio: peRatio.to_f,
        ebitda: ebitda.to_f,
        profit_margin: profitMargin.to_f,
        enterprise_value_to_revenue: enterpriseValueToRevenue.to_f,
        price_to_sales: priceToSales.to_f,
        gross_profit: grossProfit.to_f,
        revenue: revenue,
      )
      
      puts "#{stock.symbol} - collected".green
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
