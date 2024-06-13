require "sinatra/cyclist"
require 'dashing'
require 'fileutils'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'rpa01'

  helpers do
    def protected!
      # Put any authentication code you want in here.
      # This method is run before accessing any resource.
    end
  end
end

get :execution_data do |job_options|
  puts "Execution data route reached"
  # Your logic here...
end


map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

# set :cycles_configuration, [
#     {cycled_route: '_cycle1', routes: [:ksa01, :ksa02, :ksa03, :ksa04, :ksa05, :ksa06], cycle_duration: 05},
# ]
set :routes_to_cycle_through, [:rpa01, :rpa02, :rpa03, :rpa04, :rpa05, :rpa06, :rpa07, :rpa08, :rpa09]




run Sinatra::Application
