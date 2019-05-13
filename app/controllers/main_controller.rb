class MainController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'

    def scraper
        @countries = Country.all
        urls = Url.all
        url_list = []
        pages = []
        @table_headers = []
        @actual = []
        num_sec = 0.5

        @countries.each do |country|
            urls.each do |url|
               url_list << "https://tradingeconomics.com/#{country.name}/#{url.slug}"
            end 
        end

        url_list.each do |u| 
            pages << Nokogiri::HTML(HTTParty.get(u))
            puts 'page scanned and added to array'
            sleep(num_sec)
        end

       
        pages.each do |page|
            # @table_headers << page.css('#ctl00_ContentPlaceHolder1_ctl03_titleHeader').text.strip
            @actual << page.css("#ctl00_ContentPlaceHolder1_ctl03_PanelDefinition td:nth-child(2)").text.strip
            puts "header and tables grabbed"
        end

    end
end