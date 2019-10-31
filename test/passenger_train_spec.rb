require 'rspec'
require_relative '../passenger_train.rb'

describe 'PassengerTrain' do
  it 'should create train subclass of type passenger' do
    train = PassengerTrain.new
    expect(train.train_type).to eq('passenger')
    expect(train.train_type).not_to eq('cargo')
    expect(train.train_type).not_to eq('12345')
    expect(train.class).to eq(PassengerTrain)
    expect(train.carriages.length).to eq(0)
  end

  context 'Carriage manipulations' do
    before(:all) do
      @train = PassengerTrain.new
    end
    it 'should add new carriages' do
      carriage = double('PassengerCarriage', carriage_type: 'passenger')
      @train.add_carriage(carriage)
      expect(@train.carriages.length).to eq(1)
      @train.add_carriage(carriage)
      expect(@train.carriages.length).to eq(2)
      expect { @train.add_carriage('passenger') }.to raise_error(ArgumentError)
      @train.increase_speed_by(10)
      expect { @train.add_carriage('passenger') }.to raise_error(RuntimeError)
    end
  end
end
