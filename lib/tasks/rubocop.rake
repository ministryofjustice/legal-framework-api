# frozen_string_literal: true

if Gem.loaded_specs.key?("rubocop")
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end
