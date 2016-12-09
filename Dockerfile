FROM ruby:2.3.1

ENV CC clang
ENV CXX clang++

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get update -qq \
    && apt-get install -y nodejs libpq-dev postgresql-client=9.4+165+deb8u1 graphicsmagick clang

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
RUN npm install node-gyp -g
RUN npm install

COPY . /ziltag

RUN npm run build
EXPOSE 3000 3310
CMD bundle exec foreman start
