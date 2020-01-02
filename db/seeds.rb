# frozen_string_literal: true

puts 'Start seeding...'

puts 'Creating organisations'
Organisation.create(name: 'Die Partei', description: 'Das hier ist ein Parteiname')
