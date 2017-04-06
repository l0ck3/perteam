FROM ruby:2.4.0

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
  && apt-get install -yqq --no-install-recommends \
  && apt-get install \
    nodejs \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

RUN npm install -g yarn \
  && yarn global add webpack@1

RUN npm install -g webpack@1

WORKDIR /usr/src/app

COPY Gemfile* ./

ENV RAILS_ENV development

RUN bundle install

COPY package.json yarn.lock ./
RUN  yarn install

COPY . .

CMD  bundle exec puma -C config/puma.rb -p 3000