require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :valuations => :environment do
    # test_url = "https://sandbox.iexapis.com/stable/stock/aapl/advanced-stats?token=#{Rails.application.credentials.iex_hazlitt_test_key}"

    start = Time.now
    input_file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/stocks/SP500.csv"
    output_file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/lib/assets/Valuations.csv"
    File.delete(output_file) if File.exist?(output_file)

    stocks = CSV.parse(File.read(input_file, encoding: "bom|utf-8"))

    CSV.open(output_file, "wb") do |csv|
      csv << [
        "gross_profit",
        "marketcap",
        "total_debt",
        "debt_to_equity",
        "day50_moving_avg",
        "day200_moving_avg",
        "year5_changepercent",
        "year2_changepercent",
        "year1_changepercent",
        "max_changepercent",
        "week52high",
        "dividend_yield",
        "pe_ratio",
        "revenue",
        "profit_margin",
        "enterprise_value",
        "ev_to_revenue",
        "price_to_sales",
        "price_to_book",
        "ebitda",
        "put_call_ratio",
      ]

      stocks.each do |stock|
        begin
          url = "https://cloud.iexapis.com/v1/stock/#{stock}/advanced-stats?token=#{Rails.application.credentials.iex_hazlitt_key}"

          response = HTTParty.get(url, format: :plain)
          if (response.code == 200 && response.body != "Unknown symbol" && response.body != "{}")
            advanced_stats = JSON.parse response, symbolize_names: true

            csv << [
                advanced_stats[:grossProfit],
                advanced_stats[:marketcap],
                advanced_stats[:currentDebt],
                advanced_stats[:debtToEquity],
                advanced_stats[:day50MovingAvg],
                advanced_stats[:day200MovingAvg],
                advanced_stats[:year5ChangePercent],
                advanced_stats[:year2ChangePercent],
                advanced_stats[:year1ChangePercent],
                advanced_stats[:maxChangePercent],
                advanced_stats[:week52high],
                advanced_stats[:dividendYield],
                advanced_stats[:peRatio],
                advanced_stats[:revenue],
                advanced_stats[:profitMargin],
                advanced_stats[:enterpriseValue],
                advanced_stats[:enterpriseValueToRevenue],
                advanced_stats[:priceToSales],
                advanced_stats[:priceToBook],
                advanced_stats[:EBITDA],
                advanced_stats[:putCallRatio],
            ]
            puts "#{stock} - collected".green
          end
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
