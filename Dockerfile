FROM ruby:2.6.1

# Create local folder
RUN mkdir ${PWD}/myapp
WORKDIR ${PWD}/myapp

# Install Dependencies
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client --fix-missing --no-install-recommends

# Set environment variables
ENV RAILS_ENV production
ENV SECRET_KEY_BASE ccda54e450e6ed558ad346d4c3eeb619d1f7e97ac7235bf6555da5b18fd95093

# Gems
COPY Gemfile ${PWD}/myapp/Gemfile 
COPY Gemfile.lock ${PWD}/myapp/Gemfile.lock

RUN gem install bundler -v 2.0.2

RUN bundle install --deployment

COPY . ./

EXPOSE 3000

# Start the server
CMD bundle exec puma -p 3000