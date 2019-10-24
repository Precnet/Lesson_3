require 'rspec'
require_relative '../Train.rb'


# There is so much more to do with this tests, but for training purposes its enough
describe Train do

  context '#initialize' do
    it 'should create object with custom train number' do
      train = Train.new('cargo', 10, 'some_name')
      expect(train.train_number).to eq('some_name')
    end
    it 'should create random name if no one was provided' do
      train_1 = Train.new('cargo', 10)
      train_2 = Train.new('cargo', 10)
      expect(train_1.train_number).not_to eq(train_2.train_number)
    end
    it 'should create Trains with positive Integer number of carriages' do
      train = Train.new('cargo', 10)
      expect(train.number_of_carriages).to eq(10)
      expect { train = Train.new('cargo', '10') }.to raise_error(ArgumentError)
      expect { train = Train.new('cargo', ['10']) }.to raise_error(ArgumentError)
      expect { train = Train.new('cargo', {number: 10}) }.to raise_error(ArgumentError)
      expect { train = Train.new('cargo', 10.1) }.to raise_error(ArgumentError)
      expect { train = Train.new('passenger', -4) }.to raise_error(ArgumentError)
    end
    it 'should create only Trains of cargo and passenger types' do
      expect { train = Train.new('passenger', 10) }.not_to raise_error
      expect { train = Train.new('cargo', 10) }.not_to raise_error
      expect { train = Train.new('Passenger', 10) }.to raise_error(ArgumentError)
      expect { train = Train.new(10, 10) }.to raise_error(ArgumentError)
      expect { train = Train.new('personal', 10) }.to raise_error(ArgumentError)
      expect { train = Train.new(nil, 10) }.to raise_error(ArgumentError)
    end
  end

  context 'speed manipulation' do
    before(:all) do
      @train = Train.new('cargo', 10)
    end
    it 'should increase current speed by number' do
      expect(@train.increase_speed_by(10)).to eq(10)
      expect(@train.increase_speed_by(80.5)).to eq(90.5)
    end
    it 'shouldn`t increase speed to more than 120km/h' do
      expect(@train.increase_speed_by(500)).to eq(120)
    end
    it 'should decrease current speed by number' do
      expect(@train.decrease_speed_by(50)).to eq(70)
      expect(@train.decrease_speed_by(7)).to eq(63)
    end
    it 'shouldn`t decrease current speed to less than 0' do
      expect(@train.decrease_speed_by(100)).to eq(0)
    end
    it 'should stop by reducing speed to 0' do
      @train.increase_speed_by(10)
      @train.stop
      expect(@train.current_speed).to eq(0)
    end
  end

  context 'carriages manipulation' do
    before(:all) do
      @train = Train.new('cargo', 10)
    end
    it 'should increase number of carriages only if speed is 0' do
      @train.add_carriage
      expect(@train.number_of_carriages).to eq(11)
      @train.increase_speed_by(10)
      expect { @train.add_carriage }.to raise_error(RuntimeError)
    end
    it 'should decrease number of carriages by 1 if there are any' do
      11.times { @train.remove_carriage }
      expect(@train.number_of_carriages).to eq(0)
      expect { @train.remove_carriage }.to raise_error(RuntimeError)
    end
  end

end

#
# route = Route.new('First', 'Last')
# route.add_station('Second')
# route.add_station('Third')
#
# train_1.set_route(route)
# puts train_1.current_station
# puts train_1.move_forward