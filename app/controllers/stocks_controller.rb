class StocksController < ApplicationController
    require 'httparty'
    require 'nokogiri'
    require 'byebug'
    require 'enumerator'

    def stocks
        @stocks = Stock.all
    end

end