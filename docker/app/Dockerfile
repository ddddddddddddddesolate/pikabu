FROM ruby:3.0.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev 
ENV RAILS_ROOT /var/www/app
RUN mkdir -p $RAILS_ROOT 

WORKDIR $RAILS_ROOT

ENV RAILS_ENV='development'
ENV RACK_ENV='development'

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without production test

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
