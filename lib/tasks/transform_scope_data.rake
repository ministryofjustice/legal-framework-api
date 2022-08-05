FILENAME = "/Users/stephenrichards/Downloads/scopes_list.csv".freeze

desc "transforms a CSV file of scope limtiations to a yaml file suitable for reading by the ScopeLimitationPopulator"
task transform_scope_data: :environment do
  require "csv"
  array = []
  data = CSV.read(FILENAME)
  data.each do |row|
    next unless row.first == "1"

    hash = {
      code: row[1],
      meaning: row[2],
      description: row[3],
      substantive: true,
      delegated_functions: row[4] == "Both",
    }.stringify_keys
    array << hash
  end

  scopes_hash = { "scope_limitations" => array }
  puts scopes_hash.to_yaml
end
