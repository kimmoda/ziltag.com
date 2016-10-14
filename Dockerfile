FROM ruby:2.3.1

ENV NODE_VERSION 6.8.0
ENV CC clang
ENV CXX clang++

RUN apt-get update -qq \
    && apt-get install -y libpq-dev postgresql-client=9.4+165+deb8u1 graphicsmagick clang

# node
RUN curl -SL https://nodejs.org/dist/v6.4.0/node-v${NODE_VERSION}-linux-x64.tar.xz \
    | tar --strip-components 1 -xJC /usr/local
    # && npm i npm -g issue # big bug: https://github.com/npm/npm/issues/9863

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
RUN npm install

COPY . /ziltag

RUN npm run build
EXPOSE 3000 3310
CMD bundle exec foreman start
