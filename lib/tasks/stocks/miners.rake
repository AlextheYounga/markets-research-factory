require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"
require "csv"

namespace :stocks do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :miners => :environment do
    start = Time.now
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_hazlitt_key)

    input_file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/stocks/Miners.csv"
    output_file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/lib/assets/MinerAnalysis.csv"
    File.delete(output_file) if File.exist?(output_file)

    # cashflowURL = "https://sandbox.iexapis.com/stable/stock/#{ticker[0]}/cash-flow?token=#{Rails.application.credentials.iex_hazlitt_test_key}"
    file = input_file
    miners = CSV.parse(File.read(file, encoding: "bom|utf-8"))

    CSV.open(output_file, "wb") do |csv|
      csv << [
        'Name',
        'Ticker',
        'Price',
        'marketCap',
        'Country',
        'sharesOutstanding',            
        'shareholderEquity',
        'totalRevenue',
        'capitalExpenditures',
        'cashFlow',
        'freeCashFlow',
        'freeCashFlowPerShare',
        'freeCashFlowYield',
        'longTermDebt',
        'longTermDebtToEquity',
        'day5_change_percent',
        'month1_change_percent',
        'month3_change_percent',
        'ytd_change_percent'
      ]

      miners.each do |miner|
        begin
          company = StockQuote::Stock.company("#{miner}")
          quote = StockQuote::Stock.quote("#{miner}")
          keyStats = StockQuote::Stock.stats("#{miner}")
          financials = StockQuote::Stock.financials("#{miner}")
          cashflowURL = "https://cloud.iexapis.com/v1/stock/#{miner[0]}/cash-flow?token=#{Rails.application.credentials.iex_hazlitt_key}"

          cashflowResponse = HTTParty.get(cashflowURL, format: :plain)

          next if (company.nil? && quote.nil? && keyStats.nil?)
          name = company.try(:company_name) ? company.try(:company_name) : nil
          price = quote.try(:latest_price) ? quote.try(:latest_price) : nil
          country = company.try(:country) ? company.try(:country) : nil
          marketCap = keyStats.try(:marketcap) ? keyStats.try(:marketcap) : nil
          sharesOutstanding = keyStats.try(:shares_outstanding) ? keyStats.try(:shares_outstanding) : nil
          ytd_change_percent = keyStats.try(:ytd_change_percent) ? keyStats.try(:ytd_change_percent) : nil
          month3_change_percent = keyStats.try(:month3_change_percent) ? keyStats.try(:month3_change_percent) : nil
          month1_change_percent = keyStats.try(:month1_change_percent) ? keyStats.try(:month1_change_percent) : nil
          day5_change_percent = keyStats.try(:day5_change_percent) ? keyStats.try(:day5_change_percent) : nil

          if (cashflowResponse.code == 200 && cashflowResponse.body != "Unknown symbol" && cashflowResponse.body != "{}")
            cashFlowJSON = JSON.parse cashflowResponse
            capitalExpenditures = cashFlowJSON["cashflow"][0]["capitalExpenditures"] ? cashFlowJSON["cashflow"][0]["capitalExpenditures"] : nil
          end

          if (financials.try(:financials) != nil)
            shareholderEquity = financials.try(:financials)[0]["shareholderEquity"] unless financials.try(:financials)[0]["shareholderEquity"].nil?
            totalRevenue = financials.try(:financials)[0]["totalRevenue"] unless financials.try(:financials)[0]["totalRevenue"].nil?
            cashFlow = financials.try(:financials)[0]["cashFlow"] unless financials.try(:financials)[0]["cashFlow"].nil?
            longTermDebt = financials.try(:financials)[0]["longTermDebt"] unless financials.try(:financials)[0]["longTermDebt"].nil?
          end

          freeCashFlow = capitalExpenditures.to_f - cashFlow.to_f ? (capitalExpenditures && cashFlow) : nil
          freeCashFlowPerShare = freeCashFlow.to_f / sharesOutstanding.to_f ? (freeCashFlow && sharesOutstanding) : nil
          freeCashFlowYield = freeCashFlowPerShare.to_f / price.to_f ? (freeCashFlowPerShare && price) : nil
          longTermDebtToEquity = longTermDebt.to_f / shareholderEquity.to_f  ? (longTermDebt && shareholderEquity) : nil
          

          csv << [
            name,
            miner[0],
            price,
            marketCap,
            country,
            sharesOutstanding,            
            shareholderEquity,
            totalRevenue,
            capitalExpenditures,
            cashFlow,
            freeCashFlow,
            freeCashFlowPerShare,
            freeCashFlowYield,
            longTermDebt,
            longTermDebtToEquity,
            day5_change_percent,
            month1_change_percent,
            month3_change_percent,
            ytd_change_percent
          ]

          puts "#{miner[0]} saved"
        rescue => e
          puts "#{miner} - Error - #{e}"
          # log exception or ignore it.
        end
      end
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
