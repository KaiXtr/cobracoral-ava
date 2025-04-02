FROM ruby:3.2.2 AS base
RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev libvips nodejs
WORKDIR /docker/app

RUN gem install bundler
COPY Gemfile* ./
RUN bundle check || bundle install
ADD . /docker/app

COPY . ./

ARG DEFAULT_PORT 3000
EXPOSE ${DEFAULT_PORT}
CMD rails server -e production
