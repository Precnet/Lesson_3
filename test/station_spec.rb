require 'rspec'
require_relative '../Station.rb'

describe 'Station' do
  it 'should create station with custom name' do
    station = Station.new('first_station_ever')
    expect(station.name).to eq('first_station_ever')
  end
end