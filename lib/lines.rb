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
      lines << Lines.new(result)
    end
    lines
  end

  def save
    results = DB.exec("INSERT INTO lines (line_name) VALUES ('#{line_name}') RETURNING id")
    @id = results.first['id'].to_i
  end

  def ==(another_line)
    self.line_name == another_line.line_name
  end
end
