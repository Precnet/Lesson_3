require 'rspec'
require_relative '../Train.rb'

describe Train do
  it 'should create object with custom train number' do
    train = Train.new('cargo', 10, 'some_name')
    expect(train.train_number).to eq('some_name')
  end
  it 'should create random name if no one was provided' do
    train_1 = Train.new('cargo', 10)
    train_2 = Train.new('cargo', 10)
    expect(train_1.train_number).not_to eq(train_2.train_number)
  end
  it 'shouldn`t create Trains with non Integer number of carriages' do
    expect { train = Train.new('cargo', '10') }.to raise_error(ArgumentError)
    expect { train = Train.new('cargo', ['10']) }.to raise_error(ArgumentError)
    expect { train = Train.new('cargo', {number: 10}) }.to raise_error(ArgumentError)
  end
end

# describe Train do
#   it 'should create object' do
#     train = Train('cargo', 10)
#     train.train_type.should == 'cargo'
#     train.train_number.length.should == 10
#   end
# end

# train_1 = Train.new('cargo', 10)
#
# puts "Train number: #{train_1.train_number}"
# puts "Train type: #{train_1.train_type}"
# puts "Number of carriages in train: #{train_1.number_of_carriages}"
#
# puts "Train current speed is: #{train_1.current_speed} km/h"
# train_1.increase_speed_by 50
# # puts "Train current speed is: #{train_1.current_speed} km/h"
# # train_1.increase_speed_by 100
#
# train_1.decrease_speed_by(80)
# puts "Train current speed is: #{train_1.current_speed} km/h"
# train_1.decrease_speed_by 80
#
# puts "Number of carriages in train: #{train_1.number_of_carriages}"
# train_1.increase_speed_by 5
# train_1.add_carriage
# train_1.stop
# train_1.add_carriage
# puts "Number of carriages in train: #{train_1.number_of_carriages}"
#
# route = Route.new('First', 'Last')
# route.add_station('Second')
# route.add_station('Third')
#
# train_1.set_route(route)
# puts train_1.current_station
# puts train_1.move_forward