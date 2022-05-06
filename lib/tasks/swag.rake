desc "re-generate swagger documentation"
task swag: :environment do
  cmd = "rake rswag:specs:swaggerize PATTERN='spec/requests/swagger_docs/**/*_spec.rb'"
  puts ">>> #{cmd}"
  system cmd
end
