require 'sinatra'
require 'json'
require 'mysql2'

require 'yaml'

# Method to clear the history.yaml file
def clear_history_file(file_path)
  File.open(file_path, 'w') do |file|
    file.write(YAML.dump([]))  # Write an empty array as YAML to the file
  end
  puts "History file #{file_path} cleared successfully."
rescue StandardError => e
  puts "Error clearing history file: #{e.message}"
end



history_file_path = 'history.yml'
clear_history_file(history_file_path)



# POST request handler
post '/post_option' do
  content_type :json

  begin
    # Parse the JSON data sent in the request body
    request_payload = JSON.parse(request.body.read)
    selectedOption = request_payload["selectedOption"]

    # Establish a connection to the database using environment variables
    client = Mysql2::Client.new(
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_DATABASE'],
      port: ENV['DB_PORT']
    )

    # Construct the SQL DELETE statement with LIKE operator
    delete_query = "DELETE FROM Bot_Status WHERE column1 LIKE '%#{selectedOption}'"
    # Execute the delete query with parameter array
    result = client.query(delete_query)
    # Construct the SQL DELETE statement with LIKE operator
    delete_query1 = "DELETE FROM Bot_Details WHERE column1 LIKE '%#{selectedOption}'"
    # Execute the delete query with parameter array
    result1 = client.query(delete_query1)
    # Log success message
    puts "Deleted rows where column1 LIKE '#{selectedOption}'"

    # Return success response
    { success: true, message: "Tail Deleted successfully" }.to_json
  rescue JSON::ParserError => e
    status 400
    { error: "Invalid JSON format: #{e.message}" }.to_json
  rescue StandardError => e
    status 500
    { error: "Error: #{e.message}" }.to_json
  end
end
