
require 'httparty'
require 'nokogiri'
require 'resolv-replace'
require 'iex-ruby-client'
require 'json'

desc "This task scrapes hourly data from Dow Jones over the last 3 years"
task :get_hourly_quote => :environment do
puts "Collecting data"

Dailyquote.destroy_all
puts "DB cleared"

start_date = Date.parse('2019-04-01')
end_date = Date.parse('2019-10-25')

(start_date..end_date).each do |day|
    puts day
    intraday = HTTParty.get("https://cloud.iexapis.com/v1/stock/AAPL/intraday-prices?token=#{Rails.application.credentials.iex_secret_key}&exactDate=#{day.strftime('%Y%m%d')}&chartInterval=60")
    next if intraday.empty?

    price1 = intraday[0] != nil ? intraday[0]['average'] : nil
    price2 = intraday[1] != nil ? intraday[1]['average'] : nil
    price3 = intraday[2] != nil ? intraday[2]['average'] : nil
    price4 = intraday[3] != nil ? intraday[3]['average'] : nil
    price5 = intraday[4] != nil ? intraday[4]['average'] : nil
    price6 = intraday[5] != nil ? intraday[5]['average'] : nil
    price7 = intraday[6] != nil ? intraday[6]['average'] : nil

    Dailyquote.create(
        symbol: "AAPL",
        company_name: "Apple",
        date: day,
        data: {
            "9:30": "#{price1}",
            "10:30": "#{price2}",
            "11:30": "#{price3}",
            "12:30": "#{price4}",
            "1:30": "#{price5}",
            "2:30": "#{price6}",
            "3:30": "#{price7}",
        },
    )

    end
   
    puts "done."
end


