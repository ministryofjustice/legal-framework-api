# centralize coverage config
# https://github.com/simplecov-ruby/simplecov#using-simplecov-for-centralized-config
#

require "highline/import"

SimpleCov.skip "config/"
SimpleCov.skip "spec/"
SimpleCov.skip "app/channels/"
SimpleCov.skip "app/mailers/"
SimpleCov.skip "app/jobs/"
SimpleCov.skip "lib/tasks/"

SimpleCov.group "Populators", "db/populators/"
SimpleCov.group "Models", "app/models/"
SimpleCov.group "Controllers", "app/controllers/"
SimpleCov.group "Services", "app/services/"
SimpleCov.group "Validators", "app/validators/"

SimpleCov.enable_coverage :branch
SimpleCov.primary_coverage :line
SimpleCov.minimum_coverage branch: 90, line: 100
SimpleCov.refuse_coverage_drop :line, :branch
