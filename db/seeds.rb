# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require "faker"
require 'csv'

puts 'Cleaning database...'

Carrier.destroy_all
Shipper.destroy_all

puts 'Creating database...'

carrier_address_csv_file = './lib/assets/csv/carrier_address.csv'
carrier_addresses_raw_data = CSV.read(carrier_address_csv_file, headers: :first_row, skip_blanks: true)
carrier_addresses = carrier_addresses_raw_data.map do |address|
  {
    id: address["ID"],
    post_code: address["郵便番号"],
    prefecture: address["都道府県"],
    ward: address["市区町村"],
    street: address["町域"]
  }
end

pickup_address_csv_file = './lib/assets/csv/pickup_address.csv'
pickup_addresses_raw_data = CSV.read(pickup_address_csv_file, headers: :first_row, skip_blanks: true)
pickup_addresses = pickup_addresses_raw_data.map do |address|
  {
    id: address["ID"],
    post_code: address["郵便番号"],
    prefecture: address["都道府県"],
    ward: address["市区町村"],
    street: address["町域"]
  }
end

delivery_address_csv_file = './lib/assets/csv/delivery_address.csv'
delivery_addresses_raw_data = CSV.read(delivery_address_csv_file, headers: :first_row, skip_blanks: true)
delivery_addresses = delivery_addresses_raw_data.map do |address|
  {
    id: address["ID"],
    post_code: address["郵便番号"],
    prefecture: address["都道府県"],
    ward: address["市区町村"],
    street: address["町域"]
  }
end

sizes = %w(軽貨物 小型 中型 大型 その他)

vehicle_types = %w(平ボディ 平ボディ（幌付き） バン バン（保冷） バン（冷凍・冷蔵）
                   ウィング ウィング（保冷） ウィング（冷凍・冷蔵） 幌ウィング)

prefecture =
    ["北海道","青森県","秋田県","岩手県","山形県","宮城県","福島県","山梨県",
     "長野県","新潟県","富山県","石川県","福井県","茨城県","栃木県","群馬県",
     "埼玉県","千葉県","東京都","神奈川県","愛知県","静岡県","岐阜県","三重県",
     "大阪府","兵庫県","京都府","滋賀県","奈良県","和歌山県","岡山県","広島県",
     "鳥取県","島根県","山口県","徳島県","香川県","愛媛県","高知県","福岡県",
     "佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]

products =
    %w(精密機器 重量物 展示会用品 建築資材 印刷物 家具 楽器 衣料品 農産物
       食料品 美術品 仏壇・仏具 洋紙 遊技機)

industries = %w(製造 土木・建設 農業 林業 漁業 飲食 小売 卸売 印刷 商社)

time = %w(平日の午前 平日の午後 月曜日の午後 月曜日の早朝 その他)

temperature = %w(常温 保冷 冷蔵 冷凍 分からない)

additional_info = %w(パレット必要 フォークリフト必要 割れ物多数)

# Seeds for Carriers
puts 'Creating Carriers and Vehicles...'

count = 0
carrier_addresses.count.times do
  gimei_carrier = Gimei.name

  carrier = Carrier.create!(
      company_name: "#{%w(株式会社 有限会社).sample}#{gimei_carrier.last.kanji}運輸",
      post_code: carrier_addresses[count][:post_code],
      prefecture: carrier_addresses[count][:prefecture],
      ward: carrier_addresses[count][:ward],
      street: carrier_addresses[count][:street],
      areas_covered: prefecture.sample(20),
      favorite_products: products.sample(3),
      name_kanji: gimei_carrier.kanji,
      name_furigana: gimei_carrier.hiragana,
      phone: "03-#{rand(1000..9999)}-#{rand(1000..9999)}",
      email: "carrier#{carrier_addresses[count][:id]}@gmail.com",
      password: "123123"
    )

  5.times do
    vehicle = carrier.vehicles.build(
      size: sizes.sample,
      vehicle_type: vehicle_types.sample,
      quantity: rand(5..10)
      )
    vehicle.save
  end

  count += 1
end

puts 'Carriers and Vehicles Created!'

# Seeds for Carriers
puts 'Creating Shippers, Shipments, Pickups and Deliveries...'

count = 0
1.times do
  gimei_shipper = Gimei.name

  shipper = Shipper.create!(
      company_name: "#{%w(株式会社 有限会社).sample}#{gimei_shipper.last.kanji}商社",
      post_code: "211-0063",
      prefecture: "神奈川県",
      ward: "川崎市中原区",
      street: "小杉町3-472",
      industry: industries.sample,
      name_kanji: gimei_shipper.kanji,
      name_furigana: gimei_shipper.hiragana,
      phone: "03-#{rand(1000..9999)}-#{rand(1000..9999)}",
      email: "shipper#{count + 1}@gmail.com",
      password: "123123"
    )

  10.times do
    pickup_csv_id = rand(0..142)
    delivery_csv_id = rand(0..142)

    duration_start_from = Date.parse("2018/2/1")
    duration_start_to = Date.parse("2018/4/30")
    duration_end_from = Date.parse("2018/7/31")
    duration_end_to = Date.parse("2018/12/31")

    shipment = Shipment.new(
        shipper_id: shipper.id,
        available: true,
        duration_start: Random.rand(duration_start_from..duration_start_to),
        duration_end: Random.rand(duration_end_from..duration_end_to),
        frequency: %w(週に1回 2週間に1回 月に1回 その他).sample
      )

    pickup = shipment.pickups.build(
        post_code: pickup_addresses[pickup_csv_id][:post_code],
        prefecture: pickup_addresses[pickup_csv_id][:prefecture],
        ward: pickup_addresses[pickup_csv_id][:ward],
        street: pickup_addresses[pickup_csv_id][:street],
        time: time.sample,
        category: products.sample,
        size_height: rand(100..200).round(-1),
        size_width: rand(100..200).round(-1),
        size_depth: rand(100..500).round(-1),
        weight: rand(10..50).round,
        quantity: rand(10..500).round(-1),
        temperature: temperature.sample,
        additional_info: additional_info.sample
      )

    delivery = shipment.deliveries.build(
        post_code: delivery_addresses[delivery_csv_id][:post_code],
        prefecture: delivery_addresses[delivery_csv_id][:prefecture],
        ward: delivery_addresses[delivery_csv_id][:ward],
        street: delivery_addresses[delivery_csv_id][:street],
        time: time.sample
      )

    shipment.save
  end

  count += 1
end

puts 'Shippers, Shipments, Pickups and Deliveries Created!'


################################################################################
################################################################################
################################################################################
# SEEDS EXAMPLE
# seeds for programming as required skill
if false
3.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
    is_owner: true,
    address: ["Meguro, Tokyo", "Tokyo Station, Tokyo", "Shinjuku, Tokyo", "Ginza, Tokyo", "Shiodome, Tokyo", "Ebisu, Tokyo", "Ueno, Tokyo", "Roppongi, Tokyo"].sample
    )

  if user.is_owner
    3.times do
      # start_random_date = DateTime.new(2017, 11, rand(6..8))
      space = Space.new(
        name: Faker::Company.name,
        category: ["Garage", "Kitchen", "Office", "Design studio", "Coworking", "Art gallery", "Music studio"].sample,
        start_date: DateTime.new(2017, 11, 6),
        end_date: DateTime.new(2017, 11, 10),
        # start_date: start_random_date,
        # end_date: start_random_date + rand(1..2),
        daily_price: rand(5000..20000).round(-3),
        # facility: ["Wi-Fi", "Meeting rooms", "Breakout area", "Printing", "Free coffee"].sample,
        # people_capacity: ["1 person", "〜5 people", "〜10 people", "〜20 people",
        #   "〜50 people", "〜100 people", "〜200 people", "More than 200 people" ].sample,
        # floor_area: ["〜10", "11〜20", "21〜50", "50〜100", "100〜"].sample,
        opening_hours: Time.new(2017, 10, 31, 18, 0, 0),
        closing_hours: Time.new(2017, 11, 01, 02, 0, 0),
        description: "Description TBD",
        required_skill_description: "Description TBD",
        is_barter: true,
        user_id: user.id,
        city: "Tokyo",
        address: user.address,
        required_skill: "Programming"
        )


      photo_urls = {
        "Office" => ["app/assets/images/Office4.jpg"],
        "Coworking" => ["app/assets/images/Coworking4.jpg"],
        "Design studio" => ["app/assets/images/dstudio4.jpg"],
        "Kitchen" => ["app/assets/images/kitchen4.jpg"],
        "Garage" => ["app/assets/images/garage4.jpg"],
        "Art gallery" => ["app/assets/images/artgallery05.jpg"],
        "Music studio" => ["app/assets/images/musicstudio02.jpg"]
      }

      titles = {
        "Office" => "Sleek, modern office",
        "Coworking" => "Great coworking community",
        "Design studio" => "Reputable design studio",
        "Kitchen" => "Well equipped kitchen",
        "Garage" => "Garage space in Tokyo",
        "Art gallery" => "Spacious art gallery",
        "Music studio" => "High tech music studio"
      }

      facilities = {
        "Office" => "Meeting rooms",
        "Coworking" => "Wi-Fi",
        "Design studio" => "Breakout area",
        "Kitchen" => "Free coffee",
        "Garage" => "Wi-Fi",
        "Art gallery" => "Printing",
        "Music studio" => "Wi-Fi"
      }

      capacity = {
        "Office" => "〜100 people",
        "Coworking" => "〜50 people",
        "Design studio" => "〜20 people",
        "Kitchen" => "〜10 people",
        "Garage" => "〜5 people",
        "Art gallery" => "〜50 people",
        "Music studio" => "〜5 people"
      }

      floor_area = {
        "Office" => "100〜",
        "Coworking" => "100〜",
        "Design studio" => "50〜100",
        "Kitchen" => "21〜50",
        "Garage" => "11〜20",
        "Art gallery" => "100〜",
        "Music studio" => "11〜20"
      }


      space.title = titles[space.category]
      space.facility = facilities[space.category]
      space.people_capacity = capacity[space.category]
      space.floor_area = floor_area[space.category]
      space.photo_urls = photo_urls[space.category]
      space.save!

      puts 'Photo seeding...'

    end
  end
end


# seeds for other required skills
3.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
    is_owner: true,
    address: ["Meguro, Tokyo", "Tokyo Station, Tokyo", "Shinjuku, Tokyo", "Ginza, Tokyo", "Shiodome, Tokyo", "Ebisu, Tokyo", "Ueno, Tokyo", "Roppongi, Tokyo"].sample
    )

  3.times do
    skill = Skill.create!(
      skill_category: ["Web Design", "Teaching", "Programming", "Translation", "Writing"].sample,
      user_id: user.id
      )
  end

  if user.is_owner
    3.times do
      # start_random_date = DateTime.new(2017, 11, rand(6..8))
      space = Space.new(
        name: Faker::Company.name,
        category: ["Garage", "Kitchen", "Office", "Design studio", "Coworking", "Art gallery", "Music studio"].sample,
        start_date: DateTime.new(2017, 11, 6),
        end_date: DateTime.new(2017, 11, 10),
        # start_date: start_random_date,
        # end_date: start_random_date + rand(1..2),
        daily_price: rand(5000..20000).round(-3),
        # facility: ["Wi-Fi", "Meeting rooms", "Breakout area", "Printing", "Free coffee"].sample,
        # people_capacity: ["1 person", "〜5 people", "〜10 people", "〜20 people",
        #   "〜50 people", "〜100 people", "〜200 people", "More than 200 people" ].sample,
        # floor_area: ["〜10", "11〜20", "21〜50", "50〜100", "100〜"].sample,
        opening_hours: Time.new(2017, 10, 31, 18, 0, 0),
        closing_hours: Time.new(2017, 11, 01, 02, 0, 0),
        description: "Description TBD",
        required_skill_description: "Description TBD",
        is_barter: true,
        user_id: user.id,
        city: "Tokyo",
        address: user.address,
        required_skill: ["Web Design", "Teaching", "Translation", "Writing"].sample
        )


      photo_urls = {
        "Office" => ["app/assets/images/Office4.jpg"],
        "Coworking" => ["app/assets/images/Coworking4.jpg"],
        "Design studio" => ["app/assets/images/dstudio4.jpg"],
        "Kitchen" => ["app/assets/images/kitchen4.jpg"],
        "Garage" => ["app/assets/images/garage4.jpg"],
        "Art gallery" => ["app/assets/images/artgallery05.jpg"],
        "Music studio" => ["app/assets/images/musicstudio02.jpg"]
      }

      titles = {
        "Office" => "Sleek, modern office",
        "Coworking" => "Great coworking community",
        "Design studio" => "Reputable design studio",
        "Kitchen" => "Well equipped kitchen",
        "Garage" => "Garage space in Tokyo",
        "Art gallery" => "Spacious art gallery",
        "Music studio" => "High tech music studio"
      }

      facilities = {
        "Office" => "Meeting rooms",
        "Coworking" => "Wi-Fi",
        "Design studio" => "Breakout area",
        "Kitchen" => "Free coffee",
        "Garage" => "Wi-Fi",
        "Art gallery" => "Printing",
        "Music studio" => "Wi-Fi"
      }

      capacity = {
        "Office" => "〜100 people",
        "Coworking" => "〜50 people",
        "Design studio" => "〜20 people",
        "Kitchen" => "〜10 people",
        "Garage" => "〜5 people",
        "Art gallery" => "〜50 people",
        "Music studio" => "〜5 people"
      }

      floor_area = {
        "Office" => "100〜",
        "Coworking" => "100〜",
        "Design studio" => "50〜100",
        "Kitchen" => "21〜50",
        "Garage" => "11〜20",
        "Art gallery" => "100〜",
        "Music studio" => "11〜20"
      }


      space.title = titles[space.category]
      space.facility = facilities[space.category]
      space.people_capacity = capacity[space.category]
      space.floor_area = floor_area[space.category]
      space.photo_urls = photo_urls[space.category]
      space.save!

      puts 'Photo seeding...'

    end
  end
end

3.times do
  # start_random_date = DateTime.new(2017, 11, rand(6..8))
  booked_space = Space.order("RANDOM()").first
  booked_days = booked_space.end_date - booked_space.start_date + 1

  booking = Booking.create!(
    total_price: booked_days * booked_space.daily_price,
    status: "Available",
    start_date: booked_space.start_date,
    end_date: booked_space.end_date,
    user_id: User.last.id,
    space_id: booked_space.id
    )
end

puts 'Finished!'
end
