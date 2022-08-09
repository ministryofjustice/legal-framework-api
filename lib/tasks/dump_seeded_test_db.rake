namespace :db do
  namespace :test do
    namespace :populated do
      desc "Populates the test database then dumps it to a file"
      task dump: ["db:test:set_test_env", :environment] do
        puts "Populating the database"
        load(Rails.root.join("db/seeds.rb"))

        filename = Rails.root.join("spec/fixtures/seeded_db_test.sql")
        puts "Saving data to #{filename}"
        cmd = "pg_dump --file=#{filename} --clean --if-exists -d legal_framework_api_test"
        puts cmd
        system cmd
      end
    end

    # rubocop:disable Rails/RakeEnvironment
    desc "sets the test env for susequent rake tasks"
    task :set_test_env do
      puts "Setting test environment"
      Rails.env = "test"
    end
    # rubocop:enable Rails/RakeEnvironment
  end
end
