# README

To scrape country indicators:
rake app:scrape_countries

To scrape Russell 3000 for financial data:
rake app:scrape_russell3000

To calculate debt to assets for companies:
rake app:debt_to_assets

To clear each table
rake db:seed:countries_table_seeder
rake db:seed:russell3000_table_seeder