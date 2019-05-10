class MainController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'


    def scraper
        countries = Country.all
        urls = Url.all
        url_list = []
        pages = []
        @table_headers = []
        indicators = []
        @actual = []

        countries.each do |country|
            urls.each do |url|
               url_list << "https://tradingeconomics.com/#{country.name}/#{url.slug}"
            end 
        end

        url_list.each do |u| 
            pages << Nokogiri::HTML(HTTParty.get(u))
            puts 'page scanned and added to array'
        end

        pages.each do |page|
            @table_headers << page.css('#ctl00_ContentPlaceHolder1_ctl03_titleHeader').text.strip
            indicators = page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition")
            @actual << indicators.css("td:nth-child(2)").text
            puts "header and tables grabbed"
        end
        
        # indicators.each do |indicator|
        #     @actual = indicator.css("td:nth-child(2)").text
            # previous: indicator.css("td:nth-child(3)").text,
            # highest: indicator.css("td:nth-child(4)").text,
            # lowest: indicator.css("td:nth-child(5)").text,
            # dates: indicator.css("td:nth-child(6)").text,
            # unit: indicator.css("td:nth-child(7)").text,
            # frequency: indicator.css("td:nth-child(8)").text
        # end
    end
    
end