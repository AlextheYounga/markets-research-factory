require 'httparty'
require 'nokogiri'

namespace :app do
  desc "Scrape TradingEconomics for indicators"
  task :scrape => :environment do

        countries = Country.all
        num_sec = 1
        
        start = Time.now
        Rake::Task['db:seed'].invoke
        puts "DB reseeded to clear database"

        countries.each do |country|
            inflation_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/inflation-cpi"))
            Country.update(inflation: inflation_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip)
            puts "saved #{country.name} inflation data"
            sleep(num_sec)

            corporate_tax_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/corporate-tax-rate"))
            Country.update(corporate_tax: corporate_tax_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip)
            puts "saved #{country.name} corporate tax rate data"
            sleep(num_sec)

            interest_rate_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/interest-rate"))
            Country.update(interest_rate: interest_rate_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip)
            puts "saved #{country.name} interest rate data"
            sleep(num_sec)

            unemployment_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/unemployment-rate"))
            Country.update(unemployment: unemployment_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,)
            puts "saved #{country.name} unemployment data"
            sleep(num_sec)

            income_tax_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/personal-income-tax-rate"))
            Country.update(income_tax: income_tax_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,)
            puts "saved #{country.name} income tax data"
            sleep(num_sec)

            gdp_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/gdp-per-capita"))
            Country.update(gdp: gdp_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,)
            puts "saved #{country.name} gdp data"
            sleep(num_sec)

            gov_debt_to_gdp_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/government-debt-to-gdp"))
            Country.update(gov_debt_to_gdp: gov_debt_to_gdp_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,)
            puts "saved #{country.name} gov debt to gdp data"
            sleep(num_sec)

            bank_balance_sheet_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/banks-balance-sheet"))
            Country.update(bank_balance_sheet: bank_balance_sheet_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,)
            puts "saved #{country.name} banks balance sheet data"
            sleep(num_sec)

            central_bank_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/central-bank-balance-sheet"))
            Country.update(central_bank: central_bank_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip,)
            puts "saved #{country.name} central bank data"
            sleep(num_sec)

            budget_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/government-budget-value"))
            Country.update(budget: budget_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip)

            puts "Pages Scrapped, Indicators Saved"
        end

        finish = Time.now
        diff = finish - start
        puts "Done" 
        puts "Time Elapsed: #{diff}"
    end  
end