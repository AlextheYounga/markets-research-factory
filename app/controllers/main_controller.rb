class MainController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'
    
    
    def scraper
        country = Country.all
        url = Url.all
        country.each do |country|
            url.each do |url|
                source = "https://tradingeconomics.com/#{country.name}/#{url.slug}"
                unparsed_page = HTTParty.get(source)
                parsed_page = Nokogiri::HTML(unparsed_page)
                @table_headers = parsed_page.css('#ctl00_ContentPlaceHolder1_ctl03_titleHeader').text
                indicators = parsed_page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition")
                indicators.each do |indicator|
                    @indicator = {
                        actual: indicator.css("td:nth-child(2)").text,
                        previous: indicator.css("td:nth-child(3)").text,
                        highest: indicator.css("td:nth-child(4)").text,
                        lowest: indicator.css("td:nth-child(5)").text,
                        dates: indicator.css("td:nth-child(6)").text,
                        unit: indicator.css("td:nth-child(7)").text,
                        frequency: indicator.css("td:nth-child(8)").text
                    }
                end
            end
        end
    end
    
end