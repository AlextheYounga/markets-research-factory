require "httparty"
require "nokogiri"
require "resolv-replace"
require "colorize"

namespace :countries do
  desc "Scrape TradingEconomics for country indicators"
  task :worldbank => :environment do
    num_sec = 1

    start = Time.now

    Country.all.each do |country|
      inflation_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country.name}/inflation-cpi"))

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
        budget: budget_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip,
      )
      puts "Pages Scraped, Indicators Saved"
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
