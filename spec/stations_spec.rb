require 'pg'
require 'spec_helper'

describe 'Stations' do
  describe '#initialize' do
    it 'is initialized with name and line_id' do
      test_line = Stations.new(:station_name =>'tiger')
      test_line.should be_an_instance_of Stations
    end

    it 'outputs its name' do
      test_line = Stations.new('station_name' =>'tiger')
      test_line.station_name.should eq 'tiger'
    end
  end

  describe '.all' do
    it 'starts out with an empty array' do
    Stations.all.should eq []
    end
  end

  describe '#save' do
    it 'saves an instance of Stations to the database' do
      test_line = Stations.new('station_name' => 'tiger')
      test_line.save
      Stations.all.should eq [test_line]
    end

    it 'is the same line if it has the same name' do
      test_line1 = Stations.new('station_name' => 'tiger')
      test_line2 = Stations.new('station_name' => 'tiger')
      test_line1.should eq test_line2
    end
  end
end
