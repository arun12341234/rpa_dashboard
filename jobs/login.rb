require 'sinatra'
require 'json'
require 'mysql2'

# Set the session secret
set :session_secret, 'super secret'

# Enable sessions
enable :sessions

# Load the helpers


post '/login' do
  content_type :json

  # Parse the JSON data sent in the request body
  request_payload = JSON.parse(request.body.read)
  puts "request_payload"
  puts request_payload
  username = request_payload["username"]
  password = request_payload["password"]

  client = Mysql2::Client.new(
    # :host => 'localhost',
    # :username => 'root',
    # :password => 'Password@123',
    # :database => 'RPA_Dashboard'
    host: ENV['DB_HOST'],
    username: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_DATABASE'],
    port: ENV['DB_PORT']
  )

  # Query to check if the user exists
  result = client.query("SELECT * FROM users WHERE username = '#{client.escape(username)}' AND password = '#{client.escape(password)}' LIMIT 1")
  puts result

  if result.any?
    session[:user_id] = username
    { success: true }.to_json
  else
    { success: false, error: "Invalid username or password" }.to_json
  end


end


# Dashboard route
post '/check_session' do
  content_type :json
  puts session[:user_id]

  if session[:user_id]
    redirect '/dashboard'
  else
    redirect '/login'
  end
end


post '/logout' do
  content_type :json
  puts session
  session.clear
  puts session
  { success: true, message: "Logged out successfully" }.to_json
end



