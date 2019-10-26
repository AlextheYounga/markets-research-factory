# README

This scraper is built in Ruby on Rails and is designed to be run locally. 
Beginner's Quick Start:
Clone the repo into a folder on your local machine. (Ruby works best with a Mac)
Make sure Ruby is downloaded, if using the wrong version of Ruby, download RVM and switch to the correct version, (follow the instructions in the terminal).
Run 'rake db:migrate'
Run 'rake db:seed' This will insert a large quantity of initial data into the database, seed data needed to run the scrapers
Run 'rails server' to start a local server. 

After running the commands below, the data will be collected into HTML tables which you can export to Excel from your local server.


To scrape country indicators:
rake app:scrape_countries

To scrape Russell 3000 for financial data:
rake app:scrape_stocks

To calculate debt to assets for companies:
rake app:debt_to_assets

To calculate net worth for companies
rake app:net_worth

To reseed each table one at a time
rake db:seed:countries_table_seeder
rake db:seed:stocks_table_seeder
