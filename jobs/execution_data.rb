# # encoding: utf-8

# require 'mysql2'
# require 'rufus-scheduler'

# # Create a scheduler
# scheduler = Rufus::Scheduler.new

# # Define a hash to store data for each bot name
# $bot_data_hash = {}
# $bot_data_hash2 = {}
# $bot_name_indexes = {}
# # Define the task to fetch data and update the dashboard
# def fetch_and_update_dashboard2
#   client = Mysql2::Client.new(
#     host: 'localhost',
#     username: 'root',
#     password: 'Password@123',
#     database: 'RPA_Dashboard'
#   )

#   # Fetch data from MySQL
#   query = "SELECT * FROM Bot_Data ORDER BY id DESC"  # Replace 'Bot_Data' with the name of your table
#   results = client.query(query)

#   # Fetch data from MySQL
#   query2 = "SELECT * FROM Execution_Data ORDER BY id DESC"  # Replace 'Bot_Data' with the name of your table
#   results2 = client.query(query2)
#   # Define an empty array to store the fetched data
#   data = []


#   # Define a hash to keep track of the index for each bot_name
#   # bot_name_indexes = {}
#   index = 0

#   results2.each do |row|
#     # puts row
#     bot_name = row['bot_name']
#     # Initialize an array for the bot name if it doesn't exist
#     $bot_data_hash2[bot_name] ||= []
#     # Add the row data to the array corresponding to the bot name
#     $bot_data_hash2[bot_name] << row
#   end


#   # Iterate over the results and populate the data array with additional logic
#   results.each do |row|
#     bot_name = row['bot_name']
    
#     # Check if the bot_name is already in the dictionary
#     if $bot_name_indexes.key?(bot_name)
#       'Pass'
#     else
#       # If the bot_name is encountered for the first time, assign it index 0
#       $bot_name_indexes[bot_name] = index+1  # Assign a new index
#       index += 1
#     end
#     # puts bot_name
#     # puts row
#     # puts $bot_name_indexes
#     # Initialize an array for the bot name if it doesn't exist
#     $bot_data_hash[bot_name] ||= []
#     # Add the row data to the array corresponding to the bot name
#     $bot_data_hash[bot_name] << row
#     # puts $bot_data_hash
#   end
#   # Set up table headers
#   table_headers = [
#     { value: "Bot Name" }, 
#     { value: "Date released into production" }, 
#     { value: "Total records processed" }, 
#     { value: "Total failed records" }, 
#     { value: "Average processing of 1 record" },
#     { value: "Daily/Weekly/Monthly" },
#     { value: "Bot not running" },
#     { value: "Last Updated" }
#   ]
#   table_headers2 = [
#     { value: "Bot Name" },
#     { value: "Bot Details" }
#   ]
#   # puts $bot_data_hash.keys
#   # Loop through all keys in bot_data_hash
  
#   $bot_data_hash.keys.each do |key|
#     # puts "Key: #{key}"
#     pages_stats = {}
    
#     puts "Data:kkkkkkkkk #{$bot_data_hash[key][0]}"
    
#     [$bot_data_hash[key][0]].each do |row|
#       # puts "Key data: #{row}"
#       bot_name = row['bot_name']
#       date_released = row['date_released']
#       total_records_processed = row['total_records_processed']
#       total_failed_records = row['total_failed_records']
#       avg_processing_time = row['avg_processing_time']
#       processing_frequency = row['processing_frequency']
#       bot_not_running = row['bot_not_running']
#       last_updated = row['last_updated']
#       # puts pages_stats
#       pages_stats[row['id']] = {bot_name: bot_name, date_released: date_released, total_records_processed: total_records_processed, total_failed_records: total_failed_records, avg_processing_time: avg_processing_time, processing_frequency: processing_frequency, bot_not_running: bot_not_running, last_updated: last_updated}

#     end
#     # puts pages_stats
#     send_event("pages_#{key}", { table_headers: table_headers, pages: pages_stats.values })
#   end
  
#   $bot_data_hash2.keys.each do |key|
#     # puts "Key: #{key}"
#     pages_stats2 = {}
    
#     # puts "Data: #{$bot_data_hash[key]}"
    
#     $bot_data_hash2[key].each do |row|
#       # puts "Key data: #{row}"
#       bot_name = row['bot_name']
#       bot_data = row['data']
#       # puts pages_stats
#       pages_stats2[row['id']] = {bot_name: bot_name, bot_data: bot_data}

#     end
#     # puts pages_stats2
#     send_event("pages2_#{key}", { table_headers: table_headers2, pages: pages_stats2.values })


# end

# end


# # Schedule the task to run every 30 seconds
# scheduler.every '30s' do
#   fetch_and_update_dashboard2
# end


# fetch_and_update_dashboard2

