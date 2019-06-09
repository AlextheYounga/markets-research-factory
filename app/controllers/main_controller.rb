class MainController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'
    require 'enumerator'

    def home
    end

    def country_scraper
        @countries = Country.all
    end

    def russell_scraper
        @stocks = Stock.all   
    end

end