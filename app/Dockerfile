FROM ruby

MAINTAINER Yoshikawa Ryota <yoshikawa@rrreeeyyy.com>

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app

CMD ["bundle", "exec", "unicorn", "-c", "unicorn.rb"]
