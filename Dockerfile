# Use the official Ruby image as the base image
FROM ruby:3.3.0

# Update and install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs default-libmysqlclient-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN gem install thin
RUN thin -v
    
# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Bundler and dependencies from the Gemfile
RUN gem install bundler:2.5.6 && \
    bundle install --jobs 4 --retry 3

# Copy the rest of the application code into the container
COPY . .

# Expose port 3030 to the outside world
EXPOSE 3030

# Command to start the Smashing server
CMD ["bundle", "exec", "smashing", "start", "-p", "3030"]