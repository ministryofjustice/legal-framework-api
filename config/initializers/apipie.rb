Dir[File.join(__dir__, '../../app/validators', '*.rb')].sort.each { |file| require file }

Apipie.configure do |config|
  config.app_name                = 'LegalFrameworkApi'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/apipie'
  # where is your API defined?
  config.api_controllers_matcher = Rails.root.join('app/controllers/**/*.rb')
  config.translate = false
end
