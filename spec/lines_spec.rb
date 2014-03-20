require 'pg'
require 'spec_helper'

describe 'Lines' do
  describe '#initialize' do
    it 'is initialized with name and line_id' do
      test_line = Lines.new(:line_name =>'jungle')
      test_line.should be_an_instance_of Lines
    end

    it 'outputs its name' do
      test_line = Lines.new('line_name' =>'jungle')
      test_line.line_name.should eq 'jungle'
    end
  end

  describe '.all' do
    it 'starts out with an empty array' do
      Lines.all.should eq []
    end
  end

  describe '#save' do
    it 'saves an instance of Lines to the database' do
      test_line = Lines.new('line_name' => 'jungle')
      test_line.save
      Lines.all.should eq [test_line]
    end

    it 'saves with all the right information in the database' do
      test_line = Lines.new('line_name' => 'jungle')
      test_line.save
      Lines.all[0].line_name.should eq 'jungle'
    end

    it 'is the same line if it has the same name' do
      test_line1 = Lines.new('line_name' => 'jungle')
      test_line2 = Lines.new('line_name' => 'jungle')
      test_line1.should eq test_line2
    end
  end

  describe '.view' do
    it 'returns a list of all stations for a given line' do
      test_line =  Lines.new('line_name' => 'Jungle')
      test_line.save
      test_station_1 = Stations.new('station_name' => 'Tiger')
      test_station_1.save
      test_station_2 = Stations.new('station_name' => 'Leopard')
      test_station_2.save
      Lines.view('Jungle').should eq ['Tiger', 'Leopard']
    end
  end

  describe '.stops' do
    it 'associates stations with a specific line' do
      test_line = Lines.new('line_name' => 'Jungle')
      test_line.save
      test_station = Stations.new('station_name' => 'Tiger')
      test_station.save
      stop = Lines.stops(test_station.id, test_line.id)
      # puts stop
      Lines.view('Jungle').should eq ['Tiger']
      # stop.should eq test_station.id
    end
  end
end
