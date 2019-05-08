class MainController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'
    
    
    def scraper
        @country = Country.all
        @url = Url.all
        @i = 1

        # unparsed_page = HTTParty.get(source)
        # parsed_page = Nokogiri::HTML(unparsed_page)
        # table_headers = parsed_pages.css('#ctl00_ContentPlaceHolder1_ctl03_titleHeader').text
    end
    
    end