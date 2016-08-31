FROM ruby:2.3.1

ENV NODE_VERSION 6.4.0
ENV CC clang
ENV CXX clang++

RUN apt-get update -qq \
    && apt-get install -y libpq-dev postgresql-client graphicsmagick clang

# node
RUN curl -SL https://nodejs.org/dist/v6.4.0/node-v${NODE_VERSION}-linux-x64.tar.xz \
    | tar --strip-components 1 -xJC /usr/local
    # && npm i npm -g issue # big bug: https://github.com/npm/npm/issues/9863

RUN mkdir /ziltag
WORKDIR /ziltag

COPY Gemfile /ziltag/Gemfile
COPY Gemfile.lock /ziltag/Gemfile.lock
RUN echo 'gem: --no-rdoc --no-ri' > ~/.gemrc && bundle install

COPY package.json /ziltag/package.json
RUN npm install
COPY . /ziltag

RUN npm run build
