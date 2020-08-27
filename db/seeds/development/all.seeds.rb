# frozen_string_literal: true

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
  o = Organisation.create!(name: Faker::Company.unique.name, description: Faker::Quote.famous_last_words)
  o.avatar.attach(io: File.open(seed_fixtures_path('party.png')), filename: 'party.png')
end

puts 'Create region'
3.times do
  Region.create!(name: Faker::Address.unique.city)
end

puts 'Creating categories'
9.times do
  c = Category.create!(name: Faker::Restaurant.unique.name,
                       background_color: Faker::Color.hex_color, region_id: rand(1..3))
  c.avatar.attach(io: File.open(seed_fixtures_path('environment.jpg')), filename: 'environment.jpg')
end

puts 'Creating panels'
10.times do
  pa = Panel.create!(
    title: Faker::Lorem.words(number: rand(6..14)).join(' '),
    short_title: Faker::Lorem.words(number: rand(2..6)).join(' '),
    font_color: Faker::Color.hex_color,
    category: Category.order('RANDOM()').first,
    description: Faker::Quote.famous_last_words
  )
  pa.avatar.attach(io: File.open(seed_fixtures_path('co2.jpg')), filename: 'co2.jpg')
end

twitter_handles = ['plurapolit', nil, '']
website_links = ['https://www.sueddeutsche.de/', nil, '']

puts 'Creating users'
9.times do |num|
  u = User.create!(
    first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
    role: :expert, organisation: Organisation.all[num - 1], email: "#{Faker::Internet.email}#{num}",
    password: 'secret', twitter_handle: twitter_handles.sample, website_link: website_links.sample
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
audio_files = [
  'http://www.hochmuth.com/mp3/Beethoven_12_Variation.mp3', 'http://www.hochmuth.com/mp3/Haydn_Cello_Concerto_D-1.mp3',
  'http://www.hochmuth.com/mp3/Vivaldi_Sonata_eminor_.mp3', 'http://www.hochmuth.com/mp3/Bloch_Prayer.mp3',
  'http://www.hochmuth.com/mp3/Tchaikovsky_Rococo_Var_orch.mp3'
]

10.times do |panel|
  9.times do |user|
    expert = Statement.create!(
      quote: Faker::Coffee.notes,
      user: User.expert[user - 1],
      panel: Panel.all[panel - 1],
      status: rand(0..1)
    )
    community = Statement.create!(
      quote: Faker::Coffee.notes,
      user: User.default.order('RANDOM()').first,
      panel: Panel.all[panel - 1],
      status: rand(0..1)
    )

    AudioFile.create!(file_link: audio_files.sample,
                      duration_seconds: rand(60..120), statement: expert)

    AudioFile.create!(
      file_link: audio_files.sample,
      duration_seconds: rand(60..120), statement: community
    )
  end
end

AgeRange.create!([
                   { end_age: 15 }, { start_age: 16, end_age: 28 },
                   { start_age: 29, end_age: 44 }, { start_age: 45, end_age: 60 }, { start_age: 61 }
                 ])

puts 'Creating comments'
300.times do
  recipient = Statement.find(rand(1..90))
  comment = Statement.create!(
    quote: 'Das ist ein Kommentar!',
    user: User.default.order('RANDOM()').first,
    panel: recipient.panel,
    status: 1
  )
  AudioFile.create!(file_link: audio_files.sample,
                    duration_seconds: rand(60..120), statement: comment)
  Comment.create!(sender: comment, recipient: recipient)
end

puts 'Creating comments of experts'
Statement.limit(90).map do |statement|
  comment = Statement.create!(
    quote: 'Das ist ein Kommentar eines Experten!',
    user: statement.user,
    panel: statement.panel,
    status: 1
  )
  AudioFile.create!(file_link: audio_files.sample,
                    duration_seconds: rand(60..120), statement: comment)
  Comment.create!(sender: comment, recipient: statement)
end

puts 'Creating Likes'
300.times do
  Like.create(
    statement: Statement.accepted.order('RANDOM()').first,
    user: User.default.order('RANDOM()').first
  )
end

puts 'Finished seeding!'
