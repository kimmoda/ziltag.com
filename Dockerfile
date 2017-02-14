FROM ruby:2.3.3

ENV CC clang
ENV CXX clang++

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq \
    && apt-get install -y yarn nodejs libpq-dev postgresql-client=9.4+165+deb8u2 graphicsmagick clang

RUN mkdir /ziltag
WORKDIR /ziltag

COPY config/github/ziltag /ziltag/config/github/ziltag
RUN chmod 400 /ziltag/config/github/ziltag
COPY config/github/ssh_config /root/.ssh/config

# Gemfile
RUN echo 'gem: --no-rdoc --no-ri' > ~/.gemrc
RUN gem install bundler
COPY Gemfile /ziltag/Gemfile
COPY Gemfile.lock /ziltag/Gemfile.lock
RUN bundle install --retry 3 --jobs 2

# package.json
COPY package.json /ziltag/package.json
COPY yarn.lock /ziltag/yarn.lock
RUN yarn global add node-gyp
RUN yarn

COPY . /ziltag

RUN yarn run build
EXPOSE 3000 3310
CMD bundle exec foreman start
