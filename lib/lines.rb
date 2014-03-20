require 'pry'


class Lines

attr_reader :line_name, :id

  def initialize(attributes)
    @line_name = attributes['line_name']
    @id = attributes['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM lines;")
    lines = []
    results.each do |result|
      # line_name = result['line_name']
      lines << Lines.new(result)
    end
    lines
  end

  def save
    results = DB.exec("INSERT INTO lines (line_name) VALUES ('#{@line_name}') RETURNING id")
    @id = results.first['id'].to_i
  end

  def ==(another_line)
    self.line_name == another_line.line_name && self.id == another_line.id
  end

  def self.get_id(user_input)
    results = DB.exec("SELECT * FROM lines WHERE line_name = '#{user_input}';")
    inputs = []
    results.each do |result|
      inputs << result['id']
    end
    inputs[0].to_i
  end

  def self.view(user_input)
    results = DB.exec("SELECT * FROM lines WHERE line_name = '#{user_input}';")
    line_ids = []
    results.each do |result|
      line_ids << result['id'].to_i
    end

    station_ids = []
    line_ids.each do |id|
      line_stations = DB.exec("SELECT * FROM stops WHERE line_id = '#{id}';")
      station_ids << line_stations['station_id'].to_i
    end

    station_name = []
    station_ids.each do |name|
      station_name << DB.exec("SELECT * FROM stations WHERE id = '#{name}';")
    end
    station_name
  end

  def self.stops(station_input, line_input)
    DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{station_input}, #{line_input});")
  end
end
