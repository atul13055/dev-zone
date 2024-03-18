# Developers Community

## Requirements
- ruby "3.2.2"
- rails 7.0
- postgres
- node >= 14.x

## Installation
```
git clone https://github.com/atul13055/dev-zone/pull/new/master
cd dev-zone
bundle install
```
## Database setup
```
## Development Env.
rails db:create
rails db:migrate
rails db:seed

## Test Env.
RAILS_ENV=test rails db:create
RAILS_ENV=test rails db:migrate
```

## Assets installation
```
yarn install
yarn build:css
```

## Run the project
```
rails server
```
And then visit the http://localhost:3000
