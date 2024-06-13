require "rubygems"
require "roo"

# Specify the path to your local spreadsheet file
SPREADSHEET_PATH = "/home/dash-admin/Downloads/sample3.xlsx"

SCHEDULER.every '1s', :first_in => 0 do |job|
  begin
    # Open the local spreadsheet
    workbook = Roo::Spreadsheet.open(SPREADSHEET_PATH)

    # Select the first sheet in the workbook
    ws = workbook.sheet(0)

    # create an array to hold the lines
    rows = Array.new
    header = Array.new

    # other variables
    up = File.mtime(SPREADSHEET_PATH).localtime.strftime("%d.%m.%Y %H:%M")

    # fill lines
    ws.each_with_index do |row, index|
      if index == 0
        header.push({ :c1 => row[0], :c2 => row[1], :c3 => row[2], :c4 => row[3], :c5 => row[4], :c6 => row[5]})
      else
        rows.push({ :c1 => row[0], :c2 => row[1], :c3 => row[2], :c4 => row[3], :c5 => row[4], :c6 => row[5]})
      end
    end 

    send_event('spread', :modified => up, :header => header, :rows => rows)
  rescue => err
    puts "Exception: #{err}"
  end
end
