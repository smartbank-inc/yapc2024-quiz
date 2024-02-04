FROM ruby:3.3.0-bullseye

WORKDIR /api-ruby

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY app.rb ./app.rb

CMD ["bundle", "exec", "ruby", "app.rb"]
