
Country.destroy_all
Country.create([

    { name: "united-states" },
    { name: "euro-area" },
    { name: "china" },
    { name: "japan" },
    { name: "germany" },
    { name: "united-kingdom" },
    # { name: "france" },
    # { name: "india" },
    # { name: "italy" },
    # { name: "brazil" },
    # { name: "canada" },
    # { name: "south-korea" },
    # { name: "russia" },
    # { name: "spain" },
    # { name: "australia" },
    # { name: "mexico" },
    # { name: "indonesia" },
    # { name: "turkey" },
    # { name: "netherlands" },
    # { name: "switzerland" },
    # { name: "saudi-arabia" },
    # { name: "argentina" },
    # { name: "south-africa" },
    # { name: "singapore" },
    # { name: "antigua-and-barbuda" },
    # { name: "argentina" },
    # { name: "aruba" },
    # { name: "bahamas" },
    # { name: "barbados" },
    # { name: "belize" },
    # { name: "bermuda" },
    # { name: "bolivia" },
    # { name: "brazil" },
    # { name: "canada" },
    # { name: "cayman-islands" },
    # { name: "chile" },
    # { name: "colombia" },
    # { name: "costa-rica" },
    # { name: "cuba" },
    # { name: "dominica" },
    # { name: "dominican-republic" },
    # { name: "ecuador" },
    # { name: "el-salvador" },
    # { name: "grenada" },
    # { name: "guatemala" },
    # { name: "guyana" },
    # { name: "haiti" },
    # { name: "honduras" },
    # { name: "jamaica" },
    # { name: "mexico" },
    # { name: "nicaragua" },
    # { name: "panama" },
    # { name: "paraguay" },
    # { name: "peru" },
    # { name: "puerto-rico" },
    # { name: "suriname" },
    # { name: "trinidad-and-tobago" },
    # { name: "uruguay" },
    # { name: "venezuela" },
    # { name: "albania" },
    # { name: "andorra" },
    # { name: "austria" },
    # { name: "belarus" },
    # { name: "belgium" },
    # { name: "bosnia-and-herzegovina" },
    # { name: "bulgaria" },
    # { name: "croatia" },
    # { name: "cyprus" },
    # { name: "czech-republic" },
    # { name: "denmark" },
    # { name: "estonia" },
    # { name: "euro-area" },
    # { name: "faroe-islands" },
    # { name: "finland" },
    # { name: "france" },
    # { name: "germany" },
    # { name: "greece" },
    # { name: "hungary" },
    # { name: "iceland" },
    # { name: "ireland" },
    # { name: "isle-of-man" },
    # { name: "italy" },
    # { name: "kosovo" },
    # { name: "latvia" },
    # { name: "liechtenstein" },
    # { name: "lithuania" },
    # { name: "luxembourg" },
    # { name: "macedonia" },
    # { name: "malta" },
    # { name: "moldova" },
    # { name: "monaco" },
    # { name: "montenegro" },
    # { name: "netherlands" },
    # { name: "norway" },
    # { name: "poland" },
    # { name: "portugal" },
    # { name: "romania" },
    # { name: "russia" },
    # { name: "serbia" },
    # { name: "slovakia" },
    # { name: "slovenia" },
    # { name: "spain" },
    # { name: "sweden" },
    # { name: "switzerland" },
    # { name: "turkey" },
    # { name: "ukraine" },
    # { name: "united-kingdom" },
    # { name: "algeria" },
    # { name: "angola" },
    # { name: "benin" },
    # { name: "botswana" },
    # { name: "burkina-faso" },
    # { name: "burundi" },
    # { name: "cameroon" },
    # { name: "cape-verde" },
    # { name: "central-african-republic" },
    # { name: "chad" },
    # { name: "comoros" },
    # { name: "congo" },
    # { name: "djibouti" },
    # { name: "egypt" },
    # { name: "equatorial-guinea" },
    # { name: "eritrea" },
    # { name: "ethiopia" },
    # { name: "gabon" },
    # { name: "gambia" },
    # { name: "ghana" },
    # { name: "guinea" },
    # { name: "guinea-bissau" },
    # { name: "ivory-coast" },
    # { name: "kenya" },
    # { name: "lesotho" },
    # { name: "liberia" },
    # { name: "libya" },
    # { name: "madagascar" },
    # { name: "malawi" },
    # { name: "mali" },
    # { name: "mauritania" },
    # { name: "mauritius" },
    # { name: "morocco" },
    # { name: "mozambique" },
    # { name: "namibia" },
    # { name: "niger" },
    # { name: "nigeria" },
    # { name: "republic-of-the-congo" },
    # { name: "rwanda" },
    # { name: "sao-tome-and-principe" },
    # { name: "senegal" },
    # { name: "seychelles" },
    # { name: "sierra-leone" },
    # { name: "somalia" },
    # { name: "south-africa" },
    # { name: "south-sudan" },
    # { name: "sudan" },
    # { name: "swaziland" },
    # { name: "tanzania" },
    # { name: "togo" },
    # { name: "tunisia" },
    # { name: "uganda" },
    # { name: "zambia" },
    # { name: "zimbabwe" },
    # { name: "afghanistan" },
    # { name: "armenia" },
    # { name: "azerbaijan" },
    # { name: "bahrain" },
    # { name: "bangladesh" },
    # { name: "bhutan" },
    # { name: "brunei" },
    # { name: "cambodia" },
    # { name: "china" },
    # { name: "east-timor" },
    # { name: "georgia" },
    # { name: "hong-kong" },
    # { name: "india" },
    # { name: "indonesia" },
    # { name: "iran" },
    # { name: "iraq" },
    # { name: "israel" },
    # { name: "japan" },
    # { name: "jordan" },
    # { name: "kazakhstan" },
    # { name: "kuwait" },
    # { name: "kyrgyzstan" },
    # { name: "laos" },
    # { name: "lebanon" },
    # { name: "macao" },
    # { name: "malaysia" },
    # { name: "maldives" },
    # { name: "mongolia" },
    # { name: "myanmar" },
    # { name: "nepal" },
    # { name: "north-korea" },
    # { name: "oman" },
    # { name: "palestine" },
    # { name: "pakistan" },
    # { name: "philippines" },
    # { name: "qatar" },
    # { name: "saudi-arabia" },
    # { name: "singapore" },
    # { name: "south-korea" },
    # { name: "sri-lanka" },
    # { name: "syria" },
    # { name: "taiwan" },
    # { name: "tajikistan" },
    # { name: "thailand" },
    # { name: "turkmenistan" },
    # { name: "united-arab-emirates" },
    # { name: "uzbekistan" },
    # { name: "vietnam" },
    # { name: "yemen" },
    # { name: "australia" },
    # { name: "fiji" },
    # { name: "kiribati" },
    # { name: "new-caledonia" },
    # { name: "new-zealand" },
    # { name: "papua-new-guinea" },
    # { name: "samoa" },
    # { name: "solomon-islands" },
    # { name: "tonga" },
    # { name: "vanuatu" }
    
]);