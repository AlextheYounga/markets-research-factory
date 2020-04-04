
namespace :stocks do
    desc "Scrape all companies on the Russell 3000 for financial data"
    task :company => :environment do
        StockQuote::Stock.new(api_key: Rails.application.credentials.iex_public_key)

        start = Time.now
        Stock.all.each do |stock|
            ticker = stock.ticker.downcase

            company = StockQuote::Stock.company(ticker)
            abort company.inspect
            quote = StockQuote::Stock.quote(ticker)
            price = quote.try(:latest_price)

            Stock.where(ticker: "#{stock.ticker}").update(
                company_name: advanced_stats[:companyName],
                latest_price: price,
            )
        end

            finish = Time.now
            diff = finish - start
            puts "Done"
            puts "Time Elapsed: #{diff}"
    end
end