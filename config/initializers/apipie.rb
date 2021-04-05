Dir[File.join(__dir__, '../../app/validators', '*.rb')].sort.each { |file| require file }

Apipie.configure do |config|
  config.app_name                = 'Legal Framework API'
  config.api_base_url            = '/'
  config.doc_base_url            = '/apidocs'
  config.api_routes = Rails.application.routes
  # where is your API defined?
  config.api_controllers_matcher = Rails.root.join('app/controllers/**/*.rb')
  config.translate = false
  config.validate = true
  config.show_all_examples = true
  config.layout = 'apipie_override'
  config.app_info = <<-END_OF_TEXT


    == Legal Framework API

    = Overview
    This API is the single source of truth in the Apply system for all things concerning the 
    Legal Framework, i.e., Proceeding types, Scope limitations, merits taks, etc.

    Currently, only the merits_task request is implemented.

    == Usage
    = merits_tasks

      POST /merits_tasks

    The POST request to this endpoint contains an array of the legal aid application's proceeding types
    (identified by ccms_code), and the response will return a list of merits tasks for the application, and for
    each proceeding type.

  END_OF_TEXT
end
