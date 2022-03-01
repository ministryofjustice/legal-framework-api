FROM ruby:3.1.1-alpine3.15
MAINTAINER apply for legal aid team

ENV RAILS_ENV production

RUN set -ex

RUN apk --no-cache add --virtual build-dependencies \
                    build-base \
                    postgresql-dev \
&& apk --no-cache add \
                  postgresql-client \
                  nodejs \
                  shared-mime-info \
                  yarn

RUN mkdir /myapp
WORKDIR /myapp

RUN adduser --disabled-password apply -u 1001

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install nokogiri -v '1.12.5' --source 'https://rubygems.org/'

RUN gem install bundler -v 2.2.24 && bundle config --global without test:development && bundle install

COPY . /myapp

RUN yarn --prod

#RUN bundle exec rake assets:precompile SECRET_KEY_BASE=a-real-secret-key-is-not-needed-here

RUN apk del build-dependencies

EXPOSE 3000

RUN chown -R apply:apply /myapp

RUN chmod +x ./bin/uat_deploy

# expect ping environment variables
ARG BUILD_DATE
ARG BUILD_TAG
ARG APP_BRANCH
# set ping environment variables
ENV BUILD_DATE=${BUILD_DATE}
ENV BUILD_TAG=${BUILD_TAG}
ENV APP_BRANCH=${APP_BRANCH}
# allow public files to be served
ENV RAILS_SERVE_STATIC_FILES true

USER 1001

CMD "./docker_scripts/run"
