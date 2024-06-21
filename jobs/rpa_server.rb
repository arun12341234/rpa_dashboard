# encoding: utf-8

require 'mysql2'
require 'rufus-scheduler'

# Create a scheduler
scheduler = Rufus::Scheduler.new

# Define a hash to store data for each bot name
$bot_data_hash = {}
$bot_data_hash2 = {}
$bot_name_indexes = {}
# Define the task to fetch data and update the dashboard
def fetch_and_update_dashboard2
  client = Mysql2::Client.new(
    # host: 'localhost',
    # username: 'root',
    # password: 'Password@123',
    # database: 'RPA_Dashboard'
    host: ENV['DB_HOST'],
    username: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_DATABASE'],
    port: ENV['DB_PORT']
  )

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

  # Fetch data from MySQL
  query2 = "SELECT * FROM Bot_Details ORDER BY id DESC"  # Replace 'Bot_Data' with the name of your table
  results2 = client.query(query2)
  # Define an empty array to store the fetched data
  data = []
  index = 0
  results.each do |row|
    pages_stats = {}
    bot_name = row['column1'].split('::=').last.strip
    table_headers = []
    table_data = {}
    index = 1
    row.each do |key, value|
      next if value.nil?
      next unless value.is_a?(String)
      parts = value.split('::=')
      table_headers << { value: parts.first.strip }
      # Construct column name using index
      col_name = "col#{index}"
      # puts col_name
      table_data[col_name]=parts.last.strip
      index += 1
    end
    pages_stats[row['id']] = table_data
    # puts table_headers
    # puts table_data
    send_event("pages_#{bot_name}", { table_headers: table_headers, pages: pages_stats.values })
  end

  index = 0
  results2.each do |row|
    bot_name = row['column1'].split('::=').last.strip
    table_headers = []
    table_data = {}
    index = 1
    $bot_data_hash2[bot_name] ||= []
    # Add the row data to the array corresponding to the bot name
    table_data['id']=row['id']
    row.each do |key, value|
      next if value.nil?
      next unless value.is_a?(String)
      parts = value.split('::=')
      if index > 1
        table_headers << { value: parts.first.strip }
      end
      # Construct column name using index
      col_name = "col#{index}"
      # puts col_name
      table_data[col_name]=parts.last.strip
      index += 1
    end
    table_data['table_headers'] = table_headers
    $bot_data_hash2[bot_name] << table_data
    
  end
  $bot_data_hash2.keys.each do |key|
    pages_stats = {}
    table_headers = []
    $bot_data_hash2[key].each do |row_data|
      # puts row_data['table_headers']
      table_headers = row_data['table_headers']
      pages_stats[row_data['id']] = row_data
    end
    send_event("pages2_#{key}", { table_headers: table_headers, pages: pages_stats.values })
  end
end


# Schedule the task to run every 30 seconds
scheduler.every '30s' do
  fetch_and_update_dashboard2
end


fetch_and_update_dashboard2

