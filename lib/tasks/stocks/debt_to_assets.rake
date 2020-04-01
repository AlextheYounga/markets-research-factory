require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'iex-ruby-client'
require 'json'

namespace :stocks do
  desc "Calculate debt to asset ratio for each stock"
  task :debt_to_assets => :environment do

    #Calculate company's debt to assets

    start = Time.now

    Stock.all.each do |stock|
        company = Stock.where(symbol: "#{stock.symbol}")
    
        a = company.sum("total_assets") unless company.sum("total_assets") == 0
        b = company.sum("total_debt") unless company.sum("total_debt") == 0
    
        next if a.nil? || b.nil?

        c = ((b / a) * 100).to_f
 

        Stock.where(symbol: "#{stock.symbol}").update(
            debt_to_assets: c > 0 ? (sprintf "%d%%", c) : nil
        )

        Stock.where(debt_to_assets: 0).update(
            debt_to_assets: nil
        )
    
        puts "Calculated #{stock.symbol} debt to asset ratio"
        end

    finish = Time.now
    diff = finish - start
    puts "Done" 
    puts "Time Elapsed: #{diff}"
  end
end