# frozen_string_literal: true

require 'database_cleaner'

def seed_fixtures_path(file_name)
  Rails.root.join('db', 'seeds', 'fixtures', file_name)
end

puts 'ENV: Development'
puts 'Run database cleaner'
DatabaseCleaner.clean_with(:truncation)

puts 'Start seeding...'
puts 'Creating organisations'
Organisation.create!(name: 'Die Partei', description: 'Das hier ist ein Parteiname')
die_gruenen = Organisation.create!(name: 'Die Grünen', description: 'Auch ein Parteiname')

puts 'Creating users'
baerbock = User.create!(first_name: 'Annalena', last_name: 'Baerbock', role: :expert, organisation: die_gruenen)
baerbock.avatar.attach(io: File.open(seed_fixtures_path('baerbock.jpg')), filename: 'baerbock.jpg')
robin = User.create!(first_name: 'Robin', last_name: 'Zuschke', role: :default, email: 'robinzuschke@hotmail.de')
robin.avatar.attach(io: File.open(seed_fixtures_path('robin.jpeg')), filename: 'robin.jpeg')

puts 'Creating categories'
environment = Category.create!(name: 'Umwelt')
environment.avatar.attach(io: File.open(seed_fixtures_path('environment.jpg')), filename: 'environment.jpg')

puts 'Creating panels'
co2 = Panel.create!(
  title: 'Was halten Sie von der CO2 Steuer?',
  short_title: 'CO2 Steuer',
  category: environment,
  description: 'CO2 ist schlecht.'
)
co2.avatar.attach(io: File.open(seed_fixtures_path('co2.jpg')), filename: 'co2.jpg')

puts 'Finished seeding!'