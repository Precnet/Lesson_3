require 'rspec'
require_relative '../Route.rb'

describe 'Route' do
  before(:all) do
    @route = Route.new('first', 'second')
  end
  it 'should take two arguments and constructs array of initial stations' do
    expect(@route.stations.length).to eq(2)
    expect(@route.stations[0]).to eq('first')
    expect(@route.stations[1]).to eq('second')
  end
  it 'should correctly display string representation of route' do
    expect { @route.show_route }.to output("Route: first => second\n").to_stdout
    expect { @route.show_route }.not_to output("Route: second <= first\n").to_stdout
  end
end