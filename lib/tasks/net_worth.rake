require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'stock_quote'
require 'json'

namespace :app do
  desc "Calculate net worth for each stock"
  task :net_worth => :environment do

    start = Time.now

    Stock.all.each do |stock|
        company = Stock.where(symbol: "#{stock.symbol}")
    
        a = company.sum("total_assets") unless company.sum("total_assets") == 0
        b = company.sum("total_liabilities") unless company.sum("total_liabilities") == 0
    
        next if a.nil? || b.nil?

        c = (a - b)
 

        Stock.where(symbol: "#{stock.symbol}").update(
            net_worth: c > 0 ? c.to_i : nil
        )

        Stock.where(net_worth: 0).update(
            net_worth: nil
        )
    
        puts "Calculated #{stock.symbol} net worth"
        end

    finish = Time.now
    diff = finish - start
    puts "Done" 
    puts "Time Elapsed: #{diff}"
  end
end