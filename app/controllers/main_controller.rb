class MainController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'


    def scraper
        countries = Country.all
        urls = Url.all
        url_list = []
        unparsed_pages = []
        @table_headers = []

        countries.each do |country|
            urls.each do |url|
               url_list << "https://tradingeconomics.com/#{country.name}/#{url.slug}"
            end 
        end

        url_list.each do |u| 
            unparsed_pages << Nokogiri::HTML(HTTParty.get(u))
            puts 'page scanned and added to array'
        end

        unparsed_pages.each do |unparsed_page|
            @table_headers << unparsed_page.css('#ctl00_ContentPlaceHolder1_ctl03_titleHeader').text.strip
            puts "header grabbed"
        end

        # indicators = parsed_pages.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition")
        # indicators.each do |indicator|
        #     @indicator = {
        #         actual: indicator.css("td:nth-child(2)").text,
        #         previous: indicator.css("td:nth-child(3)").text,
        #         highest: indicator.css("td:nth-child(4)").text,
        #         lowest: indicator.css("td:nth-child(5)").text,
        #         dates: indicator.css("td:nth-child(6)").text,
        #         unit: indicator.css("td:nth-child(7)").text,
        #         frequency: indicator.css("td:nth-child(8)").text
        #     }
        # end

    end
    
end