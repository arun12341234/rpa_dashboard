# encoding: utf-8
require 'sinatra'
require 'json'
require 'mysql2'
require 'rufus-scheduler'

post '/change_password' do
  content_type :json
  current_password = params['current_password']
  new_password = params['new_password']
  confirm_password = params['confirm_password']

  user_id = session[:user_id]
  puts "user_id"
  puts user_id

  if new_password != confirm_password
    status 400
    return { error: 'New password and confirm password do not match' }.to_json
  end

  client = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'root',
      :password => 'Password@123',
      :database => 'RPA_Dashboard'
  )

  result = client.query("SELECT password FROM users WHERE username = '#{user_id}' LIMIT 1")
  user = result.first
  puts user
  puts user

  if user && user['password'] == current_password
    client.query("UPDATE users SET password = '#{new_password}' WHERE username = '#{user_id}'")
    status 200
    { success: 'Password changed successfully' }.to_json
  else
    status 400
    { error: 'Current password is incorrect' }.to_json
  end
end
