# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Dir[Rails.root.join('db/seed_files/*.rb')].sort.each do |seed_file|
  load seed_file
end

MatterTypePopulator.call
ProceedingTypePopulator.call
MeritsTaskPopulator.call
