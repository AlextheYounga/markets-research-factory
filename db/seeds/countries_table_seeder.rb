require "csv"
require "colorize"

Country.destroy_all

file = "/Users/alexyounger/Desktop/Development/Rails/markets-research-factory/storage/countries/Countries.csv"
countries = CSV.parse(File.read(file, encoding: 'bom|utf-8'))

countries.each do |country|
    name = country.first
    code = country.last

    Country.create([            
        name: name,
        parameter: name.downcase.parameterize,
        code: code,
    ]);
    puts "#{country.first} saved".green
end