require 'rspec'
require_relative '../cargo_carriage.rb'

describe 'CargoCarriage' do
  it 'should create cargo carriage' do
    carriage = CargoCarriage.new
    expect(carriage.carriage_type).to eq('cargo')
  end
end