# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


translist = ["English", "Arabic", "Chinese(Simplified)", "Chinese(Traditional)", "French", "German", "Hindi", "Indonesian", "Italian", "Japanese", "Korean", "Malay", "Portuguese", "Russian", "Spanish", "Thai", "Turkish", "Vietnamese"]
trans_nick = ["EN", "AR", "ZH-CN", "ZH-TW", "FR", "DE", "HI", "ID", "IT", "JA", "KO", "MS", "PT", "RU", "ES", "TH", "TR", "VI"]

0.upto(translist.count - 1) do |x|
  translanguage = Translanguage.new
  translanguage.name = translist[x]
  translanguage.nickname = trans_nick[x]
  translanguage.save
end
Notification.create(level: 0, information: "confirm email address", is_important: true)

Notification.create(level: 1, information: "confirm email resent", is_important: false)

Notification.create(level: 0, information: "company need", is_important: true)

Notification.create(level: 1, information: "account updated", is_important: false)

Notification.create(level: 0, information: "sns_confirm", is_important: true)

Notification.create(level: 1, information: "company_confirm", is_important: false)

lan_array = ["English", "Chinese", "Japanese", "Korean", "Spanich", "German", "French", "Russian", "Vietbamese", "Portuguese", "Italian", "Malay"]
lan_nick = ["EN", "ZH", "JA", "KO", "ES", "DE", "FR", "RU", "VI", "PT", "IT", "MS"]
lan_num = 0
lan_array.each do |lan|
  lan = Language.create(name: lan)
  lan.nickname = lan_nick[lan_num]
  lan.save
  lan_num = lan_num + 1
end



country_array = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua & Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"]

country_array.each do |country|
  Country.create(name: country)
end

payment_array = ["Junggle" , "VISA", "Master Card", "PayPal"]

payment_array.each do |payment|

  Payment.create(name: payment)
end

a_all = Marketingtype.new
a_all.filter = 1
a_all.name = "All"
a_all.save

ad = Marketingtype.new
ad.filter = 1
ad.name = "AD"
ad.save

online = Marketingtype.new
online.filter = 2
online.name = "Online"
online.parent_id = ad.id
online.save

online_array = ["CPC", "CPM", "CPP(cost per period)" , "Text ad" ,"Video", "SNS" ,"SEO"]
online_array.each do |element|
  filter4 = Marketingtype.new
  filter4.filter = 3
  filter4.parent_id = online.id
  filter4.name = element
  filter4.save
end

mobile = Marketingtype.new
mobile.filter = 2
mobile.name = "Mobile"
mobile.parent_id = ad.id
mobile.save

Marketingtype.create(name: "All", filter: 4, parent_id: mobile.id)
Marketingtype.create(name: "iOS", filter: 4, parent_id: mobile.id)
Marketingtype.create(name: "Android", filter: 4, parent_id: mobile.id)

ad_mobiles = ["CPI","CPI(non-incentive)","CPC", "CPM", "CPP(cost per period)", "Text ad", "Video", "SNS", "App Discovery" "Messaging", "Rank Guarantee", "Reviews & Ratings", "ASO"]

ad_mobiles.each do |ad_mobile|
  mkc = Marketingtype.create(name: ad_mobile, filter: 3, parent_id: mobile.id)
  Marketingtype.create(name: "All", filter: 4, parent_id: mkc.id)
  Marketingtype.create(name: "iOS", filter: 4, parent_id: mkc.id)
  Marketingtype.create(name: "Android", filter: 4, parent_id: mkc.id)
end


offline = Marketingtype.new
offline.name = "Offline"
offline.filter = 2
offline.parent_id = ad.id
offline.save

offline_array = ["Outdoor advertising", "Megazine", "News Paper", "Cinema", "TV", "Radio"]

offline_array.each do |element|
  Marketingtype.create(name: element, filter: 3, parent_id: offline.id)
end

promotion = Marketingtype.new
promotion.name = "Promotion"
promotion.filter = 1
promotion.save

promotion_array = ["Viral Marketing", "PR", "Reviews Sites" , "Event"]
promotion_array.each do |element|

  Marketingtype.create(name: element, filter: 3, parent_id: promotion.id)
end

management = Marketingtype.new
management.name = "Management"
management.filter = 1
management.save

management_array = ["SNS", "Community / Forum", "Customer Service(C/S)"]
management_array.each do |element|
  Marketingtype.create(name: element, filter: 3, parent_id: management.id)
end

test = Marketingtype.new
test.name = "Test"
test.filter = 1
test.save

test_array = ["CBT (Closed Beta Test)", "FGT (Focus Group Test)", "QA (Quality assuarance)"]
test_array.each do |element|

  Marketingtype.create(name: element, filter: 3, parent_id: test.id)
end

production = Marketingtype.new
production.name = "Production"
production.filter = 1
production.save

materials_array = ["Localization"]

materials_array2 = ["Trailer", "BGM", "AD Banner Design", "Stationery Design", "Goods"]

materials_array.each do |element|
  Marketingtype.create(name: element, filter: 3, parent_id: production.id)
end

materials_array2.each do |element|
  Marketingtype.create(name: element, filter: 3, parent_id: production.id, global: true)
end
