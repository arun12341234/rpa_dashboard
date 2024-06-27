require 'sinatra'
require 'json'
require 'mysql2'

require 'yaml'

# require 'yaml'

# Method to clear the history.yml file
# def clear_history_file
#   history_file = 'history.yml'

#   # Check if the file exists
#   if File.exist?(history_file)
#     # Load existing history or initialize if empty
#     history = YAML.load_file(history_file)
#     # puts history.keys
#     for entry_key in history.keys
#       # Check if the entry exists
#       if history.key?(entry_key)
#         puts entry_key
#         puts history[entry_key] #data: {"id":"tail_widget","updatedAt":1719299701056}
#         File.open(history_file, 'w') { |f| YAML.dump({}, f) }

#         # # Remove the entry
#         # history.delete(entry_key)

#         # # Save the updated history
#         # File.open(history_file, 'w') { |f| f.write(history.to_yaml) }

#         puts "Entry #{entry_key} cleared successfully from history file."
#       else
#         puts "Entry #{entry_key} does not exist in history file."
#       end
#     end
#     puts "History file #{history_file} cleared successfully."
#   else
#     puts "History file #{history_file} does not exist."
#   end
# end

# # Schedule the job to run once
# SCHEDULER.in '1s' do
#   clear_history_file
# end





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
    135.times do |i|
      puts "Iteration #{i + 1}"
      send_event "rpa_lect#{i + 1}", {}
      # Your loop body code here
    end
    # Log success message
    puts "Deleted rows where column1 LIKE '#{selectedOption}'"
    # clear_history_file()

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

# send_event "rpa_lect#{bot_name_indexes[bot_name]}", {}