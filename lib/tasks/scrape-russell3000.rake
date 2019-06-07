require 'httparty'
require 'nokogiri'
require 'resolv-replace'

namespace :app do
  desc "Scrape all companies on the Russell 3000 for financial data"
  task :scrape_russell3000 => :environment do

    num_sec = 1
    start = Time.now

    Rake::Task['db:seed'].invoke
    puts "DB reseeded to clear database"

    


  end
end