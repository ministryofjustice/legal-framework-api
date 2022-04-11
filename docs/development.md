# Development

## Initial setup
* Clone the repo
* Run `bin/setup`
* Copy the symmetric key from LastPass (hint: search `GIT_CRYPT_KEY for Legal Framework`)
* Run `git-crypt unlock ~/path/to/symmetric_key`
* Run `rake db:reset`, this will create, migrate and seed the database
* Run the tests with `bundle exec rspec`
* Run the server with `bundle exec rails s`
