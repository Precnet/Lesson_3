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
end