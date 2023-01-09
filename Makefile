install:
	bundle install

build:
	rake assets:precompile

lint:
	bundle exec rubocop ./app
	slim-lint ./app/views/

test:
	rake test

start-rake:
	bundle exec rake

.PHONY: test