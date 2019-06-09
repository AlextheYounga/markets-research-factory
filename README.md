# README

To scrape country indicators:
rake app:scrape_countries

To scrape Russell 3000 for financial data:
rake app:scrape_stocks

To calculate debt to assets for companies:
rake app:debt_to_assets

To calculate net worth for companies
rake app:net_worth

To clear each table
rake db:seed:countries_table_seeder
rake db:seed:stocks_table_seeder