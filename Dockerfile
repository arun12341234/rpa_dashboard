# Use the official Ruby image as the base image
FROM ruby:3.3.0

# Install Node.js
RUN apt-get update && \
    apt-get install -y nodejs

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN gem install bundler:2.5.6
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose port 3030 to the outside world
EXPOSE 3030

# Command to start the Smashing server
CMD ["bundle", "exec", "smashing", "start", "-p", "3030"]
