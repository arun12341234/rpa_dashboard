require 'sinatra'
require 'json'
require 'mysql2'

require 'mysql2'

def insert_data(host, username, password, database_name, table_name,data)
    begin
        # Connect to MySQL server
        client = Mysql2::Client.new(
            :host => host,
            :username => username,
            :password => password,
            :database => database_name
        )

        # Construct the SQL query for insertion
        columns = data.keys.join(', ')
        values = data.map { |key, value| "'#{client.escape(value)}'" }.join(', ')
        puts columns
        puts values

        # # Insert data into the table
        sql = "INSERT INTO #{table_name} (#{columns}) VALUES (#{values})"
        # puts sql
        client.query(sql)
    
        puts "Data inserted successfully!"
    rescue Mysql2::Error => e
        puts "Error occurred while inserting data: #{e.message}"
    ensure
        client.close if client
    end
end



def insert_data2(host, username, password, database_name, data)
    begin
        # Connect to MySQL server
        client = Mysql2::Client.new(
            :host => host,
            :username => username,
            :password => password,
            :database => database_name
        )

        # Insert data into the table
        sql = "INSERT INTO Bot_Details 
               (bot_name, data) 
               VALUES ('#{data[:bot_name]}', '#{data[:execution_data]}')"
        client.query(sql)

        puts "Data inserted successfully!"
    rescue Mysql2::Error => e
        puts "Error occurred while inserting data: #{e.message}"
    ensure
        client.close if client
    end
end




post '/insert_bot_status' do
    content_type :json

    # Parse the JSON data sent in the request body
    request_payload = JSON.parse(request.body.read)
    puts "request_payload"
    puts request_payload
    
    # Store the keys and their corresponding values in separate arrays
    keys = request_payload.keys
    values = request_payload.values

    # Construct the data hash to insert into the database
    data_to_insert = {}
    keys.each_with_index do |key, index|
        data_to_insert["column#{index + 1}"] = "#{key}::=#{values[index]}"
    end
    puts data_to_insert
    # data_to_insert2 = {
    #     :bot_name => request_payload['bot_name'],
    #     :execution_data => request_payload['execution_data'],
    # }
    

    # Insert data into MySQL database
    insert_data('localhost', 'root', 'Password@123', 'RPA_Dashboard','Bot_Status', data_to_insert)
    { message: 'Data received and inserted successfully' }.to_json
end

post '/insert_bot_details' do
    content_type :json

    # Parse the JSON data sent in the request body
    request_payload = JSON.parse(request.body.read)
    puts "request_payload"
    puts request_payload
    
    # Store the keys and their corresponding values in separate arrays
    keys = request_payload.keys
    values = request_payload.values

    # Construct the data hash to insert into the database
    data_to_insert = {}
    keys.each_with_index do |key, index|
        data_to_insert["column#{index + 1}"] = "#{key}::=#{values[index]}"
    end
    puts data_to_insert
    # Insert data into MySQL database
    insert_data('localhost', 'root', 'Password@123', 'RPA_Dashboard','Bot_Details', data_to_insert)
    { message: 'Data received and inserted successfully' }.to_json
end

