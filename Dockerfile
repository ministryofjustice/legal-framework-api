FROM ruby:3.3.1-alpine3.20
MAINTAINER apply for legal aid team

ENV RAILS_ENV production

RUN set -ex

RUN apk --no-cache add --virtual build-dependencies \
                    build-base \
                    postgresql-dev \
&& apk --no-cache add postgresql-client

RUN mkdir /myapp
WORKDIR /myapp

RUN adduser --disabled-password apply -u 1001

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY .ruby-version /myapp/.ruby-version

RUN gem update --system
RUN bundle config set --local without 'test development' && bundle install

COPY . /myapp

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
