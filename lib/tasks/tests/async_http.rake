require "async"
require "async/barrier"
require "async/http/internet"

##EXTREME CAUTION USING THIS
##THIS THING SCRAPES AT THE SPEED OF LIGHT
##GOOD WAY TO GET YOUR IP BANNED

namespace :test do
  task :async_http => :environment do
    start = Time.now

    Async do
      internet = Async::HTTP::Internet.new
      barrier = Async::Barrier.new

      Country.all.each do |country|
        inflation_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/inflation-cpi"))
        puts "got #{country.name} inflation data"
        sleep(num_sec)
        corporate_tax_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/corporate-tax-rate"))
        puts "got #{country.name} corporate tax rate data"
        sleep(num_sec)
        interest_rate_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/interest-rate"))
        puts "got #{country.name} interest rate data"
        sleep(num_sec)
        unemployment_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/unemployment-rate"))
        puts "got #{country.name} unemployment data"
        sleep(num_sec)
        income_tax_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/personal-income-tax-rate"))
        puts "got #{country.name} income tax data"
        sleep(num_sec)
        gdp_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/gdp-per-capita"))
        puts "got #{country.name} gdp data"
        sleep(num_sec)
        gov_debt_to_gdp_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/government-debt-to-gdp"))
        puts "got #{country.name} gov debt to gdp data"
        sleep(num_sec)
        bank_balance_sheet_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/banks-balance-sheet"))
        puts "got #{country.name} banks balance sheet data"
        sleep(num_sec)
        central_bank_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/central-bank-balance-sheet"))
        puts "got #{country.name} central bank data"
        sleep(num_sec)
        budget_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/government-budget-value"))

        Country.where(name: "#{country.name}").update(
          inflation: inflation_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          corporate_tax: corporate_tax_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          interest_rate: interest_rate_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          unemployment: unemployment_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          income_tax: income_tax_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          gdp: gdp_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          gov_debt_to_gdp: gov_debt_to_gdp_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          bank_balance_sheet: bank_balance_sheet_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          central_bank: central_bank_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
          budget: budget_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,
        )
        puts "Pages Scraped, Indicators Saved"
      end

      # Spawn an asynchronous task for each topic:
      Stock.all.each do |stock|
        barrier.async do
          prices = internet.get "https://www.google.com/search?q=#{stock.ticker}+prices"
          supply = internet.get "https://www.google.com/search?q=#{stock.ticker}+supply"
          demand = internet.get "https://www.google.com/search?q=#{stock.ticker}+demand"
          puts "Found #{stock.ticker}: #{prices.read.scan(stock.ticker).size} times."
          puts "Found #{stock.ticker}: #{supply.read.scan(stock.ticker).size} times."
          puts "Found #{stock.ticker}: #{demand.read.scan(stock.ticker).size} times."
        end
      end

      # Ensure we wait for all requests to complete before continuing:
      barrier.wait
      # ensure
      internet&.close
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
