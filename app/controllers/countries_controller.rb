class CountriesController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'
    require 'enumerator'

    def countries
        @countries = Country.all
    end

end