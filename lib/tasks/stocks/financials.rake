require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"
require "csv"

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :financials => :environment do
    start = Time.now
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_hazlitt_key)

    file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/stocks/Miners.csv"
    tickers = CSV.parse(File.read(file, encoding: "bom|utf-8"))

    CSV.open("/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/lib/assets/minerAdvData.csv", "wb") do |csv|
      csv << ["Ticker", "Capital Expenditures", "cashFlow", "totalRevenue", "longTermDebt", "shareholderEquity"]

      tickers.each do |ticker|
        financials = StockQuote::Stock.financials("#{ticker}")
        cashflowURL = "https://cloud.iexapis.com/v1/stock/#{ticker[0]}/cash-flow?token=#{Rails.application.credentials.iex_hazlitt_key}"
        cashflowURL = "https://sandbox.iexapis.com/stable/stock/#{ticker[0]}/cash-flow?token=#{Rails.application.credentials.iex_hazlitt_test_key}"
        cashflowResponse = HTTParty.get(cashflowURL, format: :plain)

        if (cashflowResponse.code == 200 && cashflowResponse.body != "Unknown symbol" && cashflowResponse.body != "{}")
          cashFlowJSON = JSON.parse cashflowResponse

            capitalExpenditures = cashFlowJSON["cashflow"][0]["capitalExpenditures"]

          next if financials.nil?
            shareholderEquity = financials.try(:financials)[0]["shareholderEquity"]
            totalRevenue = financials.try(:financials)[0]["totalRevenue"]
            cashFlow = financials.try(:financials)[0]["cashFlow"]
            longTermDebt = financials.try(:financials)[0]["longTermDebt"]

          csv << [ticker[0], capitalExpenditures, cashFlow, totalRevenue, longTermDebt, shareholderEquity]
          puts "#{ticker[0]} saved"
        end
      end
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end

# financials = StockQuote::Stock.financials("#{ticker}")
# cfUrl = "https://cloud.iexapis.com/v1/stock/#{ticker}/cash-flow?token=#{Rails.application.credentials.iex_hazlitt_key}"

# shareholderEquity = financials.try(:financials["shareholderEquity"])
# longTermDebt = financials.try(:financials["longTermDebt"])

# price = quote.try(:latest_price)
# keystats - sharesOutstanding
# keystats - marketcap

# company - country
# indicator - volatility
# financials - shareholderEquity
# financials - longTermDebt
# financials - totalRevenue

# csv << ["Ticker" "Market Cap", "Country", "Revenue", "Free Cash Flow Yield", "LT Debt - Equity Ratio"]
