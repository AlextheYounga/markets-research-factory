require "csv"

Country.destroy_all

CSV.foreach("storage/Countries.csv") do |row|


end

Country.create([

   
    
]);