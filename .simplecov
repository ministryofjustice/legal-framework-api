# centralize coverage config
# https://github.com/simplecov-ruby/simplecov#using-simplecov-for-centralized-config
#

unless ENV["NOCOVERAGE"]
  require "highline/import"

  SimpleCov.start do
    add_filter "config/"
    add_filter "spec/"
    add_filter "app/channels/"
    add_filter "app/mailers/"
    add_filter "app/jobs/"

    add_group "Populators", "db/populators/"
    add_group "Models", "app/models/"
    add_group "Controllers", "app/controllers/"
    add_group "Services", "app/services/"
    add_group "Validators", "app/validators/"

    minimum_coverage 100
    enable_coverage :branch
    refuse_coverage_drop :line, :branch

    at_exit do
      say("<%= color(\"Code coverage is below 100% (#{result.coverage_statistics[:line].percent.round(2)}%)\", RED) %>") if result.coverage_statistics[:line].percent < 100
      result.format!
    end
  end
end
