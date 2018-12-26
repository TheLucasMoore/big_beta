# [BigBeta.app](https://bigbeta.app)

# Development Notes
* This app uses [Postgres](https://www.postgresql.org/download/) as a database.
* To create an instance of this app locally, close this repo and run the following:
  * `rails db:create`
  * `rails db:migrate`
  * `rails db:seed` - adds the db/seeds.rb file into the database.
  * `rails server` - you'll find the app at localhost:3000