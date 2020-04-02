require "csv"
require "colorize"

Country.destroy_all

countries = CSV.read("/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/countries/Countries.csv")
countries.each do |country|
    Country.create([            
        name: country.first,
        parameter: country.first.downcase.parameterize,
        code: country.last,
    ]);
    puts "#{country.first} saved".green
end