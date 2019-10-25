require 'rspec'
require_relative '../Route.rb'

describe 'Route' do
  before(:all) do
    @route = Route.new('first', 'last')
  end
  it 'should take two arguments and constructs array of initial stations' do
    expect(@route.stations.length).to eq(2)
    expect(@route.stations[0]).to eq('first')
    expect(@route.stations[1]).to eq('last')
  end
  it 'should correctly display string representation of route' do
    expect { @route.show_route }.to output("Route: first => last\n").to_stdout
    expect { @route.show_route }.not_to output("Route: last <= first\n").to_stdout
    station_added_message = "Route: first => intermediate => last\n"
    @route.add_station('intermediate')
    expect { @route.show_route }.to output(station_added_message).to_stdout
    @route.delete_station('intermediate')
  end
  it 'should add intermediate station to route' do
    @route.add_station('new_station')
    expect(@route.stations[1]).to eq('new_station')
    expect(@route.stations.length).to eq(3)
  end
  it 'should delete station from route if there is such a station' do
    @route.add_station('wrong_station')
    expect(@route.stations.length).to eq(4)
    expect(@route.stations[-2]).to eq('wrong_station')
    @route.delete_station('wrong_station')
    expect(@route.stations.length).to eq(3)
    expect(@route.stations[-2]).to eq('new_station')
    expect { @route.delete_station('one_more_wrong_station') }.to raise_error(ArgumentError)
  end
end