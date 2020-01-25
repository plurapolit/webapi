require 'database_cleaner'

def seed_fixtures_path(file_name)
  Rails.root.join('db', 'seeds', 'fixtures', file_name)
end

puts 'ENV: Development'
puts 'Run database cleaner'
DatabaseCleaner.clean_with(:truncation)

puts 'Start seeding...'
puts 'Create an admin'
Admin.create!(email: 'caspar@plurapolit.de', password: 'seedlog')

puts 'Creating organisations'
9.times do
  Organisation.create!(name: Faker::Company.unique.name, description: Faker::Quote.famous_last_words)
end

puts 'Creating categories'
3.times do
  c = Category.create!(name: Faker::Restaurant.unique.name, background_color: Faker::Color.hex_color)
  c.avatar.attach(io: File.open(seed_fixtures_path('environment.jpg')), filename: 'environment.jpg')
end

puts 'Creating panels'
10.times do
  pa = Panel.create!(
    title: Faker::Company.catch_phrase,
    short_title: Faker::Company.buzzword,
    font_color: Faker::Color.hex_color,
    category: Category.order('RANDOM()').first,
    description: Faker::Quote.famous_last_words
  )
  pa.avatar.attach(io: File.open(seed_fixtures_path('co2.jpg')), filename: 'co2.jpg')
end

puts 'Creating users'
9.times do |num|
  u = User.create!(
    first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
    role: :expert, organisation: Organisation.all[num - 1], email: "#{Faker::Internet.email}#{num}",
    password: 'secret'
  )
  u.avatar.attach(io: File.open(seed_fixtures_path('baerbock.jpg')), filename: 'baerbock.jpg')
end

15.times do |num|
  u = User.create!(
    first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
    role: :default, email: "#{Faker::Internet.email}#{num}",
    password: 'secret'
  )
  u.avatar.attach(io: File.open(seed_fixtures_path('robin.jpeg')), filename: 'robin.jpeg')
end

puts 'Creating statements'
10.times do |panel|
  9.times do |user|
    expert = Statement.create!(
      quote: Faker::Coffee.notes,
      user: User.expert[user - 1],
      panel: Panel.all[panel - 1],
      status: rand(0..2)
    )
    community = Statement.create!(
      quote: Faker::Coffee.notes,
      user: User.default.order('RANDOM()').first,
      panel: Panel.all[panel - 1],
      status: rand(0..2)
    )

    AudioFile.create!(file_link: 'http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3',
                      duration_seconds: 90, statement: expert)

    AudioFile.create!(
      file_link: 'http://www.hochmuth.com/mp3/Tchaikovsky_Nocturne__orch.mp3',
      duration_seconds: 120, statement: community
    )
  end
end

AgeRange.create!([
                   { end_age: 15 }, { start_age: 16, end_age: 28 },
                   { start_age: 29, end_age: 44 }, { start_age: 45, end_age: 60 }, { start_age: 61 }
                 ])

puts 'Creating comments'
30.times do
  recipient = Statement.find(rand(1..90))
  comment = Statement.create!(
    quote: 'Das ist ein Kommentar!',
    user: User.default.order('RANDOM()').first,
    panel: recipient.panel,
    status: rand(0..2)
  )
  AudioFile.create!(file_link: 'http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3',
                    duration_seconds: 90, statement: comment)
  Comment.create!(sender: comment, recipient: recipient)
end

puts 'Creating Likes'
300.times do
  Like.create(
    statement: Statement.accepted.order('RANDOM()').first,
    user: User.default.order('RANDOM()').first
  )
end

puts 'Finished seeding!'
