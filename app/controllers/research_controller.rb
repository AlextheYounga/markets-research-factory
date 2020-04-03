class ResearchController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'
    require 'enumerator'

    def countries
        @countries = Country.all
    end

    def stocks
        @stocks = Stock.all
    end

end