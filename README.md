# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

ClearDB Setup ENV['DATABASE_URL']

heroku run rake db:create
heroku run rake db:migrate -a pbskrapr

redis-server
sidekiq
rails s

heroku ps:scale worker=1 -a pbskrapr
