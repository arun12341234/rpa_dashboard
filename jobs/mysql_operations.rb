# encoding: utf-8

require 'mysql2'
require 'rufus-scheduler'

# Create a scheduler
scheduler = Rufus::Scheduler.new
puts "started create tables"
# Define a method to create the table if it doesn't exist
def create_table_if_not_exists
  client = Mysql2::Client.new(
    host: ENV['DB_HOST'],
    username: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_DATABASE'],
    port: ENV['DB_PORT']
  )

  # Execute SQL to create the table if it doesn't exist
  client.query(<<-SQL)
    CREATE TABLE IF NOT EXISTS Bot_Status (
      id INT AUTO_INCREMENT PRIMARY KEY,
      column1 VARCHAR(255),
      column2 VARCHAR(255),
      column3 VARCHAR(255),
      column4 VARCHAR(255),
      column5 VARCHAR(255),
      column6 VARCHAR(255),
      column7 VARCHAR(255),
      column8 VARCHAR(255),
      column9 VARCHAR(255),
      column10 VARCHAR(255),
      column11 VARCHAR(255),
      column12 VARCHAR(255),
      column13 VARCHAR(255),
      column14 VARCHAR(255),
      column15 VARCHAR(255),
      column16 VARCHAR(255),
      column17 VARCHAR(255),
      column18 VARCHAR(255),
      column19 VARCHAR(255),
      column20 VARCHAR(255),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  SQL

  # Close the MySQL connection
  client.close
end

def create_table_if_not_exists_color_rules
    client = Mysql2::Client.new(
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_DATABASE'],
      port: ENV['DB_PORT']
    )
  
    # Execute SQL to create the table if it doesn't exist
    client.query(<<-SQL)
    CREATE TABLE IF NOT EXISTS color_rules (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title_bg_color VARCHAR(7),
        title_fg_color VARCHAR(7),
        tail_bg_color_0_25 VARCHAR(7),
        tail_bg_color_25_50 VARCHAR(7),
        tail_bg_color_50_75 VARCHAR(7),
        tail_bg_color_75_100 VARCHAR(7),
        tail_fg_color_0_25 VARCHAR(7),
        tail_fg_color_25_50 VARCHAR(7),
        tail_fg_color_50_75 VARCHAR(7),
        tail_fg_color_75_100 VARCHAR(7),
        header_bg_color VARCHAR(7),
        header_fg_color VARCHAR(7),
        page_bg_color VARCHAR(7),
        page_fg_color VARCHAR(7),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        rule_1_min VARCHAR(255),
        rule_1_max VARCHAR(255),
        rule_2_min VARCHAR(255),
        rule_2_max VARCHAR(255),
        rule_3_min VARCHAR(255),
        rule_3_max VARCHAR(255),
        rule_4_min VARCHAR(255),
        rule_4_max VARCHAR(255)
        );
    SQL
  
  
    # Close the MySQL connection
    client.close
  end
# Create the table if it doesn't exist
create_table_if_not_exists

create_table_if_not_exists_color_rules

def create_table_if_not_exists_Bot_Details
    client = Mysql2::Client.new(
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_DATABASE'],
      port: ENV['DB_PORT']
    )
  
    # Execute SQL to create the table if it doesn't exist
    client.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS Bot_Details (
        id INT AUTO_INCREMENT PRIMARY KEY,
        column1 VARCHAR(255),
        column2 VARCHAR(255),
        column3 VARCHAR(255),
        column4 VARCHAR(255),
        column5 VARCHAR(255),
        column6 VARCHAR(255),
        column7 VARCHAR(255),
        column8 VARCHAR(255),
        column9 VARCHAR(255),
        column10 VARCHAR(255),
        column11 VARCHAR(255),
        column12 VARCHAR(255),
        column13 VARCHAR(255),
        column14 VARCHAR(255),
        column15 VARCHAR(255),
        column16 VARCHAR(255),
        column17 VARCHAR(255),
        column18 VARCHAR(255),
        column19 VARCHAR(255),
        column20 VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    SQL
  
    # Close the MySQL connection
    client.close
  end

create_table_if_not_exists_Bot_Details


def create_table_if_not_exists_users
  begin
    # Create a MySQL client using environment variables
    client = Mysql2::Client.new(
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_DATABASE'],
      port: ENV['DB_PORT']  # Convert port to integer
    )
    
    # Execute SQL to create the table if it doesn't exist
    client.query(<<-SQL)
    CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50),
        password VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    SQL
    
    # Check if the admin user already exists
    result = client.query("SELECT COUNT(*) AS count FROM users WHERE username = 'admin'")
    count = result.first['count']
    
    if count.zero?
      # Insert the admin user only if it doesn't already exist
      client.query(<<-SQL)
      INSERT INTO users (username, password)
      VALUES ('admin', 'admin');
      SQL
    else
      puts "Admin user already exists. Skipping insertion."
    end
    
  rescue Mysql2::Error => e
    puts "Error creating or inserting into users table: #{e.message}"
  ensure
    # Close the MySQL connection in ensure block to ensure it's always closed
    client&.close
  end
end
create_table_if_not_exists_users

