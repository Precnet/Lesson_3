require 'rspec'
require_relative '../Station.rb'

describe 'Station' do
  it 'should create station with custom name' do
    station = Station.new('first_station_ever')
    expect(station.station_name).to eq('first_station_ever')
  end
  it 'shouldn`t create station with incorrect name' do
    expect { Station.new(nil) }.to raise_error(ArgumentError)
    expect { Station.new(2452342) }.to raise_error(ArgumentError)
    expect { Station.new(['good_station_name']) }.to raise_error(ArgumentError)
    expect { Station.new('') }.to raise_error(ArgumentError)
    expect { Station.new('very-very-very long station name') }.to raise_error(ArgumentError)
  end
  context 'trains manipulations' do
    before(:all) do
      @station = Station.new('some_station')
    end
    it 'should send trains by one' do
      train_1 = double('Train', train_type: 'cargo', train_number: '001')
      train_2 = double('Train', train_type: 'passenger', train_number: '002')
      train_3 = double('Train', train_type: 'cargo', train_number: '003')
      @station.train_arrived(train_1)
      @station.train_arrived(train_2)
      @station.train_arrived(train_3)
      @station.send_train('001')
      expect(@station.trains_at_station.length).to eq(2)
      expect { @station.send_train('004') }.to raise_error(ArgumentError)
      @station.send_train('002')
      @station.send_train('003')
      expect(@station.trains_at_station.length).to eq(0)
      expect { @station.send_train('some_value') }.to raise_error(ArgumentError)
    end
    it 'should add trains to station one by one' do
      train_1 = double('Train', train_type: 'cargo', train_number: '001')
      train_2 = double('Train', train_type: 'passenger', train_number: '002')
      train_3 = double('Train', train_type: 'cargo', train_number: '003')
      @station.train_arrived(train_1)
      expect(@station.trains_at_station.length).to eq(1)
      @station.train_arrived(train_2)
      @station.train_arrived(train_3)
      expect(@station.trains_at_station.length).to eq(3)
      expect(@station.trains_at_station[1].train_type).to eq('passenger')
      # cleaning up
      @station.send_train('001')
      @station.send_train('002')
      @station.send_train('003')
    end
    it 'should return trains currently at station' do
      train_1 = double('Train', train_type: 'cargo', train_number: '001')
      train_2 = double('Train', train_type: 'passenger', train_number: '002')
      train_3 = double('Train', train_type: 'cargo', train_number: '003')
      @station.train_arrived(train_1)
      @station.train_arrived(train_2)
      @station.train_arrived(train_3)
      expect(@station.trains_at_station).to eq([train_1, train_2, train_3])
      @station.send_train('001')
      @station.send_train('002')
      @station.send_train('003')
      expect(@station.trains_at_station).to eq([])
    end
    it 'should display trains by type' do
      train_1 = double('Train', train_type: 'cargo', train_number: '001')
      train_2 = double('Train', train_type: 'passenger', train_number: '002')
      train_3 = double('Train', train_type: 'cargo', train_number: '003')
      @station.train_arrived(train_1)
      @station.train_arrived(train_2)
      @station.train_arrived(train_3)
      expect(@station.trains_at_station_of_type('cargo')).to eq(%w(001 003))
      expect(@station.trains_at_station_of_type('passenger')).to eq(%w(002))
    end
  end
end