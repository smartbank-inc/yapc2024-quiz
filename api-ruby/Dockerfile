FROM ruby:3.2.3-bullseye

WORKDIR /api-ruby

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY app.rb ./app.rb

CMD ["bundle", "exec", "ruby", "app.rb"]
