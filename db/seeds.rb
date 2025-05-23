# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rails.root.glob("db/populators/*.rb").sort.each do |seed_file|
  load seed_file
end

MatterTypePopulator.call
# The following calls ProceedingTypePopulator.call
# and ensures the textsearchable field is populated
ProceedingType.populate
MeritsTaskPopulator.call
ProceedingTypeMeritsTaskPopulator.call
TaskDependencyPopulator.call
ScopeLimitationsPopulator.call
ServiceLevelsPopulator.call
ProceedingTypeServiceLevelsPopulator.call
ThresholdWaiverPopulator.call
OrganisationTypesPopulator.call
OrganisationsPopulator.call
Country.populate
