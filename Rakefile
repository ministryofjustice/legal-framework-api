# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
# Workaround for https://github.com/rswag/rswag/issues/359
if defined? RSpec
  RSpec.configure do |config|
    config.swagger_dry_run = false
  end
end
Rails.application.load_tasks

unless Rails.env.production?
  Rake::Task[:default].clear if Rake::Task.task_defined?(:default)
  task default: %i[rubocop spec]
end
