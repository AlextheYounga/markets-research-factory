require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :valuations => :environment do
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_hazlitt_key)
    # test_url = "https://sandbox.iexapis.com/stable/stock/aapl/advanced-stats?token=#{Rails.application.credentials.iex_hazlitt_test_key}"

    start = Time.now
    Stock.all.each do |stock|

        # next if stock.id < [insert id]      

        ticker = stock.ticker.downcase
        url = "https://cloud.iexapis.com/v1/stock/#{ticker}/advanced-stats?token=#{Rails.application.credentials.iex_hazlitt_key}"
                    
        response = HTTParty.get(url, format: :plain)
        if (response.code == 200 && response.body != "Unknown symbol" && response.body != "{}")
            advanced_stats = JSON.parse response, symbolize_names: true

            # Fetch latest price
            quote = StockQuote::Stock.quote(ticker)
            abort quote.inspect
            price = quote.try(:latest_price)

            Stock.where(ticker: "#{stock.ticker}").update(
                company_name: advanced_stats[:companyName],
                latest_price: price,
                gross_profit: advanced_stats[:grossProfit],
                marketcap: advanced_stats[:marketcap],
                total_debt: advanced_stats[:currentDebt],
                debt_to_equity: advanced_stats[:debtToEquity],
                day50_moving_avg: advanced_stats[:day50MovingAvg],
                day200_moving_avg: advanced_stats[:day200MovingAvg],
                year5_changepercent: advanced_stats[:year5ChangePercent],
                year2_changepercent: advanced_stats[:year2ChangePercent],
                year1_changepercent: advanced_stats[:year1ChangePercent],
                max_changepercent: advanced_stats[:maxChangePercent],
                week52high: advanced_stats[:week52high],
                dividend_yield: advanced_stats[:dividendYield],
                pe_ratio: advanced_stats[:peRatio],
                revenue: advanced_stats[:revenue],
                profit_margin: advanced_stats[:profitMargin],
                enterprise_value: advanced_stats[:enterpriseValue],
                ev_to_revenue: advanced_stats[:enterpriseValueToRevenue],
                price_to_sales: advanced_stats[:priceToSales],
                price_to_book: advanced_stats[:priceToBook],
                ebitda: advanced_stats[:EBITDA],
                put_call_ratio: advanced_stats[:putCallRatio],
            )
            abort
            puts "#{stock.ticker} - collected".green
        end
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
