require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'colorize'

namespace :countries do
  desc "Scrape TradingEconomics for country indicators"
  task :gdp => :environment do

        num_sec = 1        
        start = Time.now
        COUNTRIES = [
            'Argentina',
            'Belarus',
            'Brazil',
            'Croatia',
            'Georgia',
            'Germany',
            'India',
            'Kazakhstan',
            'Kyrgyzstan',
            'Macedonia',
            'Peru',
            'Romania',
            'Slovakia',
            'Ukraine',
            'Uruguay',
            'West Bank and Gaza',
        ]

        COUNTRIES.each do |country|
            country = country.downcase.parameterize
            gdp_page = Nokogiri::HTML(HTTParty.get("https://tradingeconomics.com/#{country}/gdp"))                       
            gdp_unformatted = gdp_page.css("#ctl00_ContentPlaceHolder1_ctl00_IndicatorSummaryUC_PanelDefinition td:nth-child(2)").text.strip
            gdp = gdp_unformatted.to_i * 1000000000 
            puts "#{country} - #{gdp}".green            

            sleep(num_sec)
        end

        finish = Time.now
        diff = finish - start
        puts "Done" 
        puts "Time Elapsed: #{diff}"
    end  
end