require "httparty"
require "nokogiri"
require "resolv-replace"
require "colorize"

namespace :stocks do
  desc "Grab tickers from google"
  task :tickers => :environment do

    num_sec = 0.3
    start = Time.now
    STOCKS = [
        "Acacia Mining",
      "Agnico Eagle",
      "Agnico Eagle Mines Ltd.",
      "Alacer Gold",
      "Alacer Gold Corp.",
      "Alamos Gold Inc.",
      "Alcyone Resources",
      "Alexco Resource",
      "American Creek Resources",
      "Anglogold Ashanti",
      "AngloGold Ashanti Ltd.",
      "Argonaut Gold",
      "Arian Silver",
      "Asanko Gold",
      "Atac Resources",
      "Atlius",
      "Aurcana Corporation",
      "Aurico Metals",
      "Auryn Resources",    
      "B2gold corp",
      "B2Gold Corp.",
      "Barrick Gold Corp.",
      "Batero Gold Corp",
      "Beadell Resources",
      "Bear Creek Mining",
      "Belo Sun Mining",
      "Bonterra Resources",
      "Bravada Gold Corp",
      "Buena Ventura",
      "Calibre Mining",
    ]

    STOCKS.each do |stock|
        parameter = stock.gsub(" ", "+")
        search = open("https://www.marketwatch.com/tools/quotes/lookup.asp?siteID=mktw&Lookup=#{parameter}&Country=us&Type=All")
        html = Nokogiri::HTML(search)
        ticker = html.css("#symbollookup > div > table > tbody > tr:nth-child(1) > td:nth-child(1) > a").text.strip
        puts "#{stock} - #{ticker}".green

        sleep(num_sec)
    end

    finish = Time.now
    diff = finish - start
    puts "Done"
    puts "Time Elapsed: #{diff}"
  end
end
