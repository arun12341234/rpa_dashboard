require 'sinatra'
require 'json'
require 'mysql2'

post '/update_color' do
  puts params
  title_bg_color = params[:title_bg_color]
  title_fg_color = params[:title_fg_color]
  tail_bg_color_0_25 = params[:tail_bg_color_0_25]
  tail_bg_color_25_50 = params[:tail_bg_color_25_50]
  tail_bg_color_50_75 = params[:tail_bg_color_50_75]
  tail_bg_color_75_100 = params[:tail_bg_color_75_100]
  tail_fg_color_0_25 = params[:tail_fg_color_0_25]
  tail_fg_color_25_50 = params[:tail_fg_color_25_50]
  tail_fg_color_50_75 = params[:tail_fg_color_50_75]
  tail_fg_color_75_100 = params[:tail_fg_color_75_100]
  header_bg_color = params[:header_bg_color]
  header_fg_color = params[:header_fg_color]

  page_bg_color = params[:page_bg_color]
  page_fg_color = params[:page_fg_color]


  rule_1_min_value = params[:rule_1_min]
  rule_1_max_value = params[:rule_1_max]
  rule_2_min_value = params[:rule_2_min]
  rule_2_max_value = params[:rule_2_max]
  rule_3_min_value = params[:rule_3_min]
  rule_3_max_value = params[:rule_3_max]
  rule_4_min_value = params[:rule_4_min]
  rule_4_max_value = params[:rule_4_max]
  
  begin
    # Connect to MySQL server
    client = Mysql2::Client.new(
        :host => 'localhost',
        :username => 'root',
        :password => 'Password@123',
        :database => 'RPA_Dashboard'
    )

    # Insert data into the table
    sql = "INSERT INTO color_rules 
           (title_bg_color, 
            title_fg_color,
            tail_bg_color_0_25, 
            tail_bg_color_25_50, 
            tail_bg_color_50_75, 
            tail_bg_color_75_100,
            tail_fg_color_0_25, 
            tail_fg_color_25_50, 
            tail_fg_color_50_75, 
            tail_fg_color_75_100,
            header_bg_color, 
            header_fg_color, 
            page_bg_color, 
            page_fg_color,
            rule_1_min, 
            rule_1_max, 
            rule_2_min, 
            rule_2_max, 
            rule_3_min, 
            rule_3_max, 
            rule_4_min, 
            rule_4_max) 
       VALUES ('#{title_bg_color}', 
               '#{title_fg_color}', 
               '#{tail_bg_color_0_25}', 
               '#{tail_bg_color_25_50}', 
               '#{tail_bg_color_50_75}', 
               '#{tail_bg_color_75_100}', 
               '#{tail_fg_color_0_25}', 
               '#{tail_fg_color_25_50}', 
               '#{tail_fg_color_50_75}', 
               '#{tail_fg_color_75_100}', 
               '#{header_bg_color}', 
               '#{header_fg_color}', 
               '#{page_bg_color}', 
               '#{page_fg_color}',
               '#{rule_1_min_value}', 
               '#{rule_1_max_value}', 
               '#{rule_2_min_value}', 
               '#{rule_2_max_value}', 
               '#{rule_3_min_value}', 
               '#{rule_3_max_value}', 
               '#{rule_4_min_value}', 
               '#{rule_4_max_value}')"
    client.query(sql)

    puts "Data inserted successfully!"
rescue Mysql2::Error => e
    puts "Error occurred while inserting data: #{e.message}"
ensure
    client.close if client
end

end