require 'rspec'
require_relative '../Train.rb'

describe Train do
  context '' do

  end
  it 'should create simple object' do
    train = Train.new('cargo', 10)
    expect(train.train_type).to eq('cargo')
    expect(train.train_number.length).to eq(10)
  end
  it 'should create object with custom name' do
    train = Train.new('cargo', 10, 'some_name')
    expect(train.train_number).to eq('some_name')
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