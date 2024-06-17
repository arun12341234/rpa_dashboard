# encoding: utf-8

require 'mysql2'
require 'rufus-scheduler'

# Create a scheduler
scheduler = Rufus::Scheduler.new
# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1s', :first_in => 0 do |job|
    # Create a MySQL client instance
    client = Mysql2::Client.new(
        :host => 'localhost',
        :username => 'root',
        :password => 'Password@123',
        :database => 'RPA_Dashboard'
      )
    
    # Query to get the last row from color_rules
    query = "SELECT * FROM color_rules ORDER BY id DESC LIMIT 1;"

    result = client.query(query)

    # Fetch the last row
    color_rules = result.first

    # Print the last row
    # puts color_rules
    client.close
    send_event "color_rules", color_rules
end
SCHEDULER.every '1m', :first_in => 0 do |job|
  # Create a MySQL client instance
  client = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'root',
      :password => 'Password@123',
      :database => 'RPA_Dashboard'
    )
  
  # Query to get the last row from color_rules
  query = "SELECT * FROM color_rules ORDER BY id DESC LIMIT 1;"

  result = client.query(query)

  # Fetch the last row
  color_rules = result.first

  # Print the last row
  puts color_rules
  client.close
  send_event "color_rules2", color_rules
end



post '/get_current_user' do
  content_type :json
  { user_id: session[:user_id] }.to_json
end
