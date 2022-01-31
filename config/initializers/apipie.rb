Dir[File.join(__dir__, "../../app/validators", "*.rb")].sort.each { |file| require file }

Apipie.configure do |config|
  config.app_name                = "LegalFrameworkApi"
  config.api_base_url            = "/"
  config.doc_base_url            = "/apidocs"
  # where is your API defined?
  config.api_controllers_matcher = Rails.root.join("app/controllers/**/*.rb")
  config.translate = false
  config.validate = true
  config.app_info = <<~END_OF_TEXT
            == Legal Framework API
    #{'    '}
            = Overview
            This API is used by Apply to be the single source of truth for all things concerning the#{' '}
            legal framework, i.e. Matter types, Proceeding types, Scope limitations, merits tasks.
    #{'    '}
            Currently, only one endpoint has been implemented:  /merits_tasks (see below)
    #{'    '}
            == Usage
        #{'    '}
    #{'    '}
              POST /merits_task
    #{'    '}
            The payload to this endpoint includes an array of ccms_codes for the proceeding types in
            an application.  The response details all the merits tasks that are required at an application level,
            and for each proceeding type.
    #{'    '}
  END_OF_TEXT
end
