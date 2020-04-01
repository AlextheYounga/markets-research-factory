require "httparty"
require "nokogiri"
require "resolv-replace"
require "stock_quote"
require "json"
require "csv"

namespace :test do
  desc "Scrape all companies on the NSYE for their names"
  task :country_csv => :environment do

    start = Time.now
    countries = CSV.read("/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/Countries.csv")

    countries.each do |country|
      puts "#{country.first}".green
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
