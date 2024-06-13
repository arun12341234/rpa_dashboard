# # encoding: utf-8

# require 'mysql2'
# require 'rufus-scheduler'

# # Create a scheduler
# scheduler = Rufus::Scheduler.new

# # Define a method to create the table if it doesn't exist
# def create_table_if_not_exists
#   client = Mysql2::Client.new(
#     host: 'localhost',
#     username: 'root',
#     password: 'Password@123',
#     database: 'RPA_Dashboard'
#   )

#   # Execute SQL to create the table if it doesn't exist
#   client.query(<<-SQL)
#     CREATE TABLE IF NOT EXISTS Bot_Details (
#       id INT AUTO_INCREMENT PRIMARY KEY,
#       column1 VARCHAR(255),
#       column2 VARCHAR(255),
#       column3 VARCHAR(255),
#       column4 VARCHAR(255),
#       column5 VARCHAR(255),
#       column6 VARCHAR(255),
#       column7 VARCHAR(255),
#       column8 VARCHAR(255),
#       column9 VARCHAR(255),
#       column10 VARCHAR(255),
#       column11 VARCHAR(255),
#       column12 VARCHAR(255),
#       column13 VARCHAR(255),
#       column14 VARCHAR(255),
#       column15 VARCHAR(255),
#       column16 VARCHAR(255),
#       column17 VARCHAR(255),
#       column18 VARCHAR(255),
#       column19 VARCHAR(255),
#       column20 VARCHAR(255),
#       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
#     )
#   SQL

#   # Close the MySQL connection
#   client.close
# end

# # Define the task to fetch data and update the dashboard
# def fetch_and_update_dashboard
#   client = Mysql2::Client.new(
#     host: 'localhost',
#     username: 'root',
#     password: 'Password@123',
#     database: 'RPA_Dashboard'
#   )

#   # Fetch data from MySQL
#   query = "SELECT * FROM Bot_Details ORDER BY id DESC"  # Replace 'Bot_Data' with the name of your table
#   results = client.query(query)
#   puts "results:-"
#   puts results

#   # Close the MySQL connection
#   client.close
# end

# # Schedule the task to run every 30 seconds
# scheduler.every '30s' do
#   fetch_and_update_dashboard
# end

# # Create the table if it doesn't exist
# create_table_if_not_exists

# # Run the task once immediately
# fetch_and_update_dashboard

# # Run the scheduler
# scheduler.join
