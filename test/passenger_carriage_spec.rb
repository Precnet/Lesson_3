require 'rspec'
require_relative '../passenger_carriage.rb'

describe 'PassengerCarriage' do
  it 'should create passenger carriage' do
    carriage = PassengerCarriage.new
    expect(carriage.carriage_type).to eq('passenger')
  end
end