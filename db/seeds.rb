# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require "faker"

puts 'Cleaning database...'
# Carrier.destroy_all

puts 'Creating database...'

# seeds for Carriers
count = 1
5.times do
  puts "03-#{rand(1000..9999)}-#{rand(1000..9999)}"
  puts "carrier#{count}@gmail.com"

  # carrier = Carrier.create!(
  #   company_name:,
  #   post_code: "211-0063",
  #   prefecture:,
  #   ward:,
  #   street:,
  #   areas_covered:,
  #   favorite_products:,
  #   name_kanji:,
  #   name_furigana:,
  #   phone: "03-#{rand(1000..9999)}-#{rand(1000..9999)}",
  #   email: "carrier#{count}@gmail.com",
  #   password: "123123"
  #   )
  count += 1
end

puts 'Finished!'

################################################################################
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
