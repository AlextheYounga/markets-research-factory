require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'colorize'

namespace :countries do
  desc "Scrape TradingEconomics for country indicators"
  task :indicators => :environment do

        num_sec = 1
        
        start = Time.now

        Country.all.each do |country|
            inflation_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/inflation-cpi"))
            puts "got #{country.name} inflation data".green
            sleep(num_sec)
            corporate_tax_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/corporate-tax-rate"))
            puts "got #{country.name} corporate tax rate data".green
            sleep(num_sec)
            interest_rate_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/interest-rate"))
            puts "got #{country.name} interest rate data".green
            sleep(num_sec)
            unemployment_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/unemployment-rate"))
            puts "got #{country.name} unemployment data".green
            sleep(num_sec)
            income_tax_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/personal-income-tax-rate"))
            puts "got #{country.name} income tax data".green
            sleep(num_sec)
            gdp_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/gdp-per-capita"))
            puts "got #{country.name} gdp data".green
            sleep(num_sec)
            gov_debt_to_gdp_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/government-debt-to-gdp"))
            puts "got #{country.name} gov debt to gdp data".green
            sleep(num_sec)
            bank_balance_sheet_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/banks-balance-sheet"))
            puts "got #{country.name} banks balance sheet data".green
            sleep(num_sec)
            central_bank_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/central-bank-balance-sheet"))
            puts "got #{country.name} central bank data".green
            sleep(num_sec)
            budget_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/government-budget-value"))

        
        Country.where(name: "#{country.name}").update(
            inflation: inflation_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            corporate_tax: corporate_tax_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            interest_rate: interest_rate_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            unemployment: unemployment_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            income_tax: income_tax_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            gdp: gdp_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            gov_debt_to_gdp: gov_debt_to_gdp_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            bank_balance_sheet: bank_balance_sheet_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            central_bank: central_bank_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
            budget: budget_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip
            )
            puts "Pages Scraped, Indicators Saved"
        end

        finish = Time.now
        diff = finish - start
        puts "Done" 
        puts "Time Elapsed: #{diff}"
    end  
end