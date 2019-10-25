require 'rspec'
require_relative '../Route.rb'

describe 'Route' do
  context 'initialize' do
    it 'takes only two arguments and constructs array of initial stations' do
      route = Route.new('first', 'second')
      expect(route.stations.length).to eq(2)
      expect(route.stations[0]).to eq('first')
      expect(route.stations[1]).to eq('second')
    end
  end
end