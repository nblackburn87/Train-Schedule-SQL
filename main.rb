require './lib/lines'
require './lib/stations'
require 'PG'

DB = PG.connect({:dbname => 'train_system'})

def main_menu
  puts "Press 'l' to add a new line."
  puts "Press 's' to add a new station."
  puts "Press 'j' to add a new stop."
  puts "Press 'v' to view all stops on a line."
  puts "Press 'w' to view all stops at a station."
  puts "Press 'x' to exit."

  menu_choice = gets.chomp

  case menu_choice
  when 'l'
    add_line
  when 's'
    add_station
  when 'j'
    add_stop
  when 'v'
    view_line
  when 'w'
    view_station
  when 'x'
    exit
  else
    puts "Please enter a valid input.\n"
    main_menu
  end
end

def add_line
  puts "What is the new line name?"
  user_input = gets.chomp
  new_line = Lines.new('line_name' => user_input)
  new_line.save
  puts "Line Added! \n"
  main_menu
end

def add_station
  puts "What is the new station name?"
  user_input = gets.chomp
  new_station = Stations.new('station_name' => user_input)
  new_station.save
  puts "Station Added! \n"
  main_menu
end

def line_list
  Lines.all.each_with_index do |line, index|
    puts "#{line.line_name}"
  end
end

def station_list
  Stations.all.each_with_index do |station, index|
    puts "#{station.station_name}"
  end
end

def add_stop
  puts "What line is this stop on?"
  line_list
  line_input = gets.chomp
  line_input = Lines.get_id(line_input)
  puts "What station is the stop at?"
  station_list
  station_input = gets.chomp
  station_input = Stations.get_id(station_input)
  Lines.stops(station_input, line_input)
  puts "Stop added!"
  main_menu
end

def view_line
  puts 'What line would you like to view stops for?'
  line_list
  user_input = gets.chomp
  puts Lines.view(user_input)
  main_menu
end

def view_station

end

main_menu
