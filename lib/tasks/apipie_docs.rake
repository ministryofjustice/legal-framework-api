namespace :apipie do
  desc "Generate API documentation"
  task docs: :environment do
    `APIPIE_RECORD=examples bundle exec rspec`
  end
end
