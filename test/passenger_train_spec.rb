require 'rspec'
require_relative '../passenger_train.rb'

describe 'PassengerTrain' do
  it 'should create train subclass of type passenger' do
    train = PassengerTrain.new
    expect(train.train_type).to eq('passenger')
    expect(train.train_type).not_to eq('cargo')
    expect(train.train_type).not_to eq('12345')
    expect(train.class).to eq(PassengerTrain)
  end
end