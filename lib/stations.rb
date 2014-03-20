class Stations

attr_reader :station_name, :id

  def initialize(attributes)
    @station_name = attributes['station_name']
    @id = attributes['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM stations;")
    stations = []
    results.each do |result|
      stations << Stations.new(result)
    end
    stations
  end

  def save
    results = DB.exec("INSERT INTO stations (station_name) VALUES ('#{station_name}') RETURNING id")
    @id = results.first['id'].to_i
  end

  def ==(another_station)
    self.station_name == another_station.station_name
  end

  def self.get_id(user_input)
    results = DB.exec("SELECT * FROM stations WHERE station_name = '#{user_input}';")
    inputs = []
    results.each do |result|
      inputs << result['id']
    end
    inputs[0].to_i
  end
end
