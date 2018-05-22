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

vehicle_types =
  %w(バン 平ボディ 平ボディ・幌 ウィング・アルミ ウィング・幌 ユニック ダンプ 重機運搬)

type_specifications = %w(標準 ワイド ロング ワイド＆ロング)

feature = %w(標準 パワーゲート エアサス パワーゲート＆エアサス 冷蔵・冷凍 保冷)

strength_1 =
  %w(丁寧な梱包と時間通りの運送！ 全国どこでも365日24時間対応！ 倉庫で一時お預かり可能！ 経験豊富な専門ドライバーが担当)

strength_2 =
  %w(精密機器・医療機器の運送なら世界最高レベルの配送技能を誇る！ 重量物運搬の実績多数、お任せください！
     パワーゲート車、エアサス車完備！ 展示会・物産展等のイベントへの搬入・搬出を一括でお引受け致します！)

company_description =
  ["業界屈指の実績を誇る展示会物流や、高級・大型ディスプレイやインテリアを安心確実に輸送・保管します。私たちはお客様のニーズやさまざまなケースに合わせ、多様な車種をご用意し、全国どこでも柔軟に対応いたします。",
    "見本市や展示会の輸送ならお任せ下さい！全国のドームやイベントホールへの搬入実績多数。店舗やオフィスの新店オープンに伴う搬入や撤去作業も、テナントや立地問わずお引き受けします。",
    "機械物、厨房機器などの重量物は重たい物は1t（トン）を超え、搬出入時、運送やトラック内への荷物固定時、運搬時、あらゆる場面で経験と専門のノウハウが必要になります。 当社では現場臨機応変に対応できる専門のスタッフで対応しております。",
    "運送というと普通は4tや10tのトラックを思い浮かべると思います。 弊社では平ボディ車だけでなくセルフ車やユニック車を用意しています。 また、それらでは運べないような大きい物や重たい物はトレーラーで運搬します。 47t積高床トレーラーや50t積低床トレーラー(リアタイヤ舵切り仕様)、35t積低床トレーラー(エアサス、リアタイヤ舵切り仕様)など超重量物でも様々な現場やいろんな用途に対応できます。 安定したサービスの維持を実現するとともに、緊急時の要請にも即応します。",
    "高度なノウハウを必要とする超精密機器の輸送も、経験豊富なスタッフと超精密機器専用トラックにより、確実かつ迅速に輸送いたします。 確かな精密機器輸送・超精密機器輸送・重量機器の搬出搬入技術が、製品の品質をしっかり守ります。"]

prefecture =
    ["北海道","青森県","秋田県","岩手県","山形県","宮城県","福島県","山梨県",
     "長野県","新潟県","富山県","石川県","福井県","茨城県","栃木県","群馬県",
     "埼玉県","千葉県","東京都","神奈川県","愛知県","静岡県","岐阜県","三重県",
     "大阪府","兵庫県","京都府","滋賀県","奈良県","和歌山県","岡山県","広島県",
     "鳥取県","島根県","山口県","徳島県","香川県","愛媛県","高知県","福岡県",
     "佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]

products =
    %w(農産物 水産品 石油 石炭 食料品 飲料等 繊維・衣料品 木材・木製品 紙・紙加工品 出版・印刷物 化学製品・ゴム製品 窯業・土石製品 鉄鋼・金属製品 機械・機械部品 家電品・家電部品 輸送機械・輸送機械部品 日用品・雑貨 砂利・砂・石材 廃棄物 コンテナ 引越貨物 その他)

industries = %w(製造 土木・建設 農業 林業 漁業 飲食 小売 卸売 印刷 商社)

time = %w(平日の午前 平日の午後 月曜日の午後 月曜日の早朝 その他)

temperature = %w(常温 保冷 冷蔵・冷凍 分からない)

additional_info = %w(パレット必要 フォークリフト必要 割れ物多数)

duration_start_from = Date.parse("2018/2/1")
duration_start_to = Date.parse("2018/4/30")
duration_end_from = Date.parse("2018/7/31")
duration_end_to = Date.parse("2018/12/31")

# Seeds for Carriers
puts 'Creating Carriers and Vehicles...'

count = 0
carrier_addresses.count.times do
  gimei_carrier = Gimei.name

  carrier = Carrier.new(
      visible: true,
      company_name: "#{%w(株式会社 有限会社).sample}#{gimei_carrier.last.kanji}運輸",
      post_code: carrier_addresses[count][:post_code],
      prefecture: carrier_addresses[count][:prefecture],
      ward: carrier_addresses[count][:ward],
      street: carrier_addresses[count][:street],
      areas_covered: prefecture.sample(20),
      favorite_products: products.sample(3),
      ceo_name: gimei_carrier.kanji,
      name_kanji: gimei_carrier.kanji,
      name_furigana: gimei_carrier.hiragana,
      phone: "03-#{rand(1000..9999)}-#{rand(1000..9999)}",
      email: "carrier#{carrier_addresses[count][:id]}@gmail.com",
      password: "123123",
      founded_date_year: rand(1900..2018),
      founded_date_month: rand(1..12),
      capital: %w(100万円 200万円 300万円 400万円 500万円).sample,
      employee_numbers: %w(1~20 21~40 41~60 61~80 81~100 101+).sample,
      strength_1: strength_1.sample,
      strength_2: strength_2.sample,
      company_description: company_description.sample,
      specialties: %w(会社規模 緊急対応 運送地域 価格 車両種類).shuffle
    )

  carrier.update(
      site_url: ["www.#{carrier.company_name}.co.jp", ""].sample,
    )

  5.times do
    vehicle = carrier.vehicles.build(
      load_capacity: rand(1..10),
      vehicle_type: vehicle_types.sample,
      type_specifications: type_specifications.sample,
      feature: feature.sample,
      quantity: rand(2..10)
      )
    vehicle.save
  end

  carrier.save
  count += 1
end

puts 'Carriers and Vehicles Created!'

## Seeds for Carriers
# puts 'Creating Shippers, Shipments, Pickups and Deliveries...'

# count = 0
# 1.times do
#   gimei_shipper = Gimei.name

#   shipper = Shipper.create!(
#       company_name: "#{%w(株式会社 有限会社).sample}#{gimei_shipper.last.kanji}商社",
#       post_code: "211-0063",
#       prefecture: "神奈川県",
#       ward: "川崎市中原区",
#       street: "小杉町3-472",
#       industry: industries.sample,
#       name_kanji: gimei_shipper.kanji,
#       name_furigana: gimei_shipper.hiragana,
#       phone: "03-#{rand(1000..9999)}-#{rand(1000..9999)}",
#       email: "shipper#{count + 1}@gmail.com",
#       password: "123123"
#     )

#   10.times do
#     pickup_csv_id = rand(0..142)
#     delivery_csv_id = rand(0..142)

#     shipment = Shipment.new(
#         shipper_id: shipper.id,
#         available: true,
#         duration_start: Random.rand(duration_start_from..duration_start_to),
#         duration_end: Random.rand(duration_end_from..duration_end_to),
#         frequency: %w(週に1回 2週間に1回 月に1回 その他).sample
#       )

#     pickup = shipment.pickups.build(
#         post_code: pickup_addresses[pickup_csv_id][:post_code],
#         prefecture: pickup_addresses[pickup_csv_id][:prefecture],
#         ward: pickup_addresses[pickup_csv_id][:ward],
#         street: pickup_addresses[pickup_csv_id][:street],
#         time: time.sample,
#         category: products.sample,
#         size_height: rand(100..200).round(-1),
#         size_width: rand(100..200).round(-1),
#         size_depth: rand(100..500).round(-1),
#         weight: rand(10..50).round,
#         quantity: rand(10..500).round(-1),
#         temperature: temperature.sample,
#         additional_info: additional_info.sample
#       )

#     delivery = shipment.deliveries.build(
#         post_code: delivery_addresses[delivery_csv_id][:post_code],
#         prefecture: delivery_addresses[delivery_csv_id][:prefecture],
#         ward: delivery_addresses[delivery_csv_id][:ward],
#         street: delivery_addresses[delivery_csv_id][:street],
#         time: time.sample
#       )

#     shipment.save
#   end

#   count += 1
# end

# puts 'Shippers, Shipments, Pickups and Deliveries Created!'


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
