# Use Debian Trixie as the base image
FROM docker.io/debian:trixie

# Install Ruby and build-essential
RUN apt-get update
RUN apt-get install -y ruby-full ruby-dev build-essential

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Set the working directory
WORKDIR /srv/jekyll

# Expose port 4000
EXPOSE 4000