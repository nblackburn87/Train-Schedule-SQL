require 'pg'
require 'spec_helper'

describe 'Lines' do
  describe '#initialize' do
    it 'is initialized with name and line_id' do
      test_line = Lines.new(:line_name =>'tiger')
      test_line.should be_an_instance_of Lines
    end

    it 'outputs its name' do
      test_line = Lines.new('line_name' =>'tiger')
      test_line.line_name.should eq 'tiger'
    end
  end

  describe '.all' do
    it 'starts out with an empty array' do
    Lines.all.should eq []
    end
  end

  describe '#save' do
    it 'saves an instance of Lines to the database' do
      test_line = Lines.new('line_name' => 'tiger')
      test_line.save
      Lines.all.should eq [test_line]
    end

    it 'is the same line if it has the same name' do
      test_line1 = Lines.new('line_name' => 'tiger')
      test_line2 = Lines.new('line_name' => 'tiger')
      test_line1.should eq test_line2
    end
  end
end
