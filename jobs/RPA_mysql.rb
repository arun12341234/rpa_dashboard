# encoding: utf-8

require 'mysql2'
require 'rufus-scheduler'

# Create a scheduler
scheduler = Rufus::Scheduler.new
# helpers "mysql_operations.rb";
require_relative 'mysql_operations'


# Define the task to fetch data and update the dashboard
def fetch_and_update_dashboard
  # Debugging: Print environment variables
  puts "DB_HOST: #{ENV['DB_HOST']}"
  puts "DB_USERNAME: #{ENV['DB_USERNAME']}"
  puts "DB_PASSWORD: #{ENV['DB_PASSWORD']}"
  puts "DB_DATABASE: #{ENV['DB_DATABASE']}"
  puts "DB_PORT: #{ENV['DB_PORT']}"
  client = Mysql2::Client.new(
    # host: 'localhost',
    # username: 'root',
    # password: 'Password@123',
    # database: 'RPA_Dashboard'
    host: "#{ENV['DB_HOST']}",
    username: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_DATABASE'],
    port: ENV['DB_PORT']
  )
  # Debugging: Ensure the client is connected and using the correct database
  db_selected = client.query('SELECT DATABASE()').first
  puts "Database selected: #{db_selected}"

  # Fetch data from MySQL
  query = "SELECT bd.*
            FROM Bot_Status bd
            INNER JOIN (
                SELECT column1, MAX(id) AS max_id
                FROM Bot_Status
                GROUP BY column1
            ) max_ids
            ON bd.column1 = max_ids.column1 AND bd.id = max_ids.max_id;"  # Replace 'Bot_Data' with the name of your table
  results = client.query(query)

  # Define an empty array to store the fetched data
  data = []


  # Define a hash to keep track of the index for each bot_name
  bot_name_indexes = {}
  index = 0

  # Iterate over the results and populate the data array with additional logic
  results.each do |row|
    # puts row
    bot_name = row['column1'].split('::=').last.strip
    # puts bot_name
    # Check if the bot_name is already in the dictionary
    if bot_name_indexes.key?(bot_name)
      puts 'Pass'
    else
      # If the bot_name is encountered for the first time, assign it index 0
      bot_name_indexes[bot_name] = index+1  # Assign a new index
      index += 1
    end
    dataid = "rpa_lect#{bot_name_indexes[bot_name]}"
    comp_record = row['column2'].split('::=').last.strip
    total_record = row['column3'].split('::=').last.strip
    percentage = (comp_record.to_f / total_record.to_f) * 100

    data << {
      dataid: dataid,
      bot_name: bot_name,
      column3: total_record,
      last_updated: row['created_at'],
      column2: comp_record,
      percentage: percentage.round
    }

  end

  # Close the database connection
  client.close


  # Create a MySQL client instance
  client = Mysql2::Client.new(
      # :host => 'localhost',
      # :username => 'root',
      # :password => 'Password@123',
      # :database => 'RPA_Dashboard'
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: "#{ENV['DB_DATABASE']}",
      port: ENV['DB_PORT']
    )
  
  # Query to get the last row from color_rules
  query = "SELECT * FROM color_rules ORDER BY id DESC LIMIT 1;"

  result = client.query(query)

  # Fetch the last row
  color_rules = result.first

  # Print the last row
  # puts color_rules
  client.close


  # Update the dashboard with the fetched data
  data.each do |h|

    # puts h
    send_event h[:dataid], {
      suf_bot_name: "BOT",
      dataid: h[:dataid],
      bot_name: h[:bot_name],
      total_record: h[:column3],
      last_updated: h[:last_updated],
      comp_record: h[:column2],
      current: h[:percentage], 
      last: h[:percentage],
      symble: "%",
      stat:h[:column2]+"/"+h[:column3],
      color_rules: color_rules
    }
  end
end

# Schedule the task to run every 30 seconds
scheduler.every '30s' do
  fetch_and_update_dashboard
end

# Initial run of the task
fetch_and_update_dashboard
