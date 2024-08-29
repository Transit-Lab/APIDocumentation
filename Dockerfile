# Use a newer Ruby base image
FROM ruby:2.6.10

# Set environment variables for bundler
ENV BUNDLER_VERSION=2.2.33

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libxml2-dev \
  libxslt1-dev \
  nodejs \
  dos2unix

# Create and set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install bundler and the project gems
RUN gem install bundler -v "$BUNDLER_VERSION" && bundle install

# Copy the rest of the application code into the container
COPY . .
