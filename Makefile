install:
	bundle install

lint:
	bundle exec rubocop ./app
	slim-lint ./app/views/

test:
	rake test

start-rake:
	bundle exec rake

.PHONY: test