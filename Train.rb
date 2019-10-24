class Train
  attr_accessor :number_of_carriages
  attr_reader :train_number, :train_type, :current_speed, :current__station

  def initialize(train_type, number_of_carriages, train_number = generate_train_number(10))
    # nice little magick with converting int to str with Base36
    @train_number = train_number
    @number_of_carriages = number_of_carriages
    # check train type
    @train_type = check_train_type(train_type)
    @current_speed = 0
    # route and station management
    @current__station = nil
    @route = nil
  end

  def generate_train_number(number_length)
    rand(36 ** number_length).to_s(36)
  end

  def check_train_type(train_type)
    errorMessage = "Wrong type of a train! Should be 'cargo' or 'passenger'. Got - '#{train_type}'"
    raise ArgumentError, errorMessage unless %w(passenger cargo).include? train_type
    train_type
  end

  def increase_speed_by(km)
    @current_speed += km
    if @current_speed > 120
      @current_speed = 120
      puts "Train is at it`s maximum speed - 120km/h. It can`t safely increase it`s speed any more."
    end
    current_speed
  end

  def decrease_speed_by(km)
    @current_speed -= km
    if @current_speed < 0
      @current_speed = 0
      puts "Train had already stopped. It can`t decrease it`s speed any more."
    end
    current_speed
  end

  def stop
    @current_speed = 0
  end

  def add_carriage
    if @current_speed == 0 then @number_of_carriages += 1 else puts 'Can`t add new carriages while train is moving.' end
  end

  def remove_carriage
    if @number_of_carriages > 0 then @number_of_carriages -= 1 else puts 'There are no carriages to remove.' end
  end

  def set_route(route)
    @route = route
    @current__station = route.stations[0]
  end

  def move_forward
    event_no_route = 'Train can`t move without any route!'
    return event_no_route unless @route
    event_last_station = 'Train is already at it`s final station and can`t move further!'
    return event_last_station if @route.find_index(@current__station) == @route.length - 1


  end

  def move_backward
    puts 'Train can`t move without any route!' unless @route
  end

  def get_previous_station

  end

  def get_next_station

  end

  private :check_train_type, :generate_train_number
end


train_1 = Train.new('cargo', 10)

puts "Train number: #{train_1.train_number}"
puts "Train type: #{train_1.train_type}"
puts "Number of carriages in train: #{train_1.number_of_carriages}"

puts "Train current speed is: #{train_1.current_speed} km/h"
train_1.increase_speed_by 50
puts "Train current speed is: #{train_1.current_speed} km/h"
train_1.increase_speed_by 100

train_1.decrease_speed_by(80)
puts "Train current speed is: #{train_1.current_speed} km/h"
train_1.decrease_speed_by 80

puts "Number of carriages in train: #{train_1.number_of_carriages}"
train_1.increase_speed_by 5
train_1.add_carriage
train_1.stop
train_1.add_carriage
puts "Number of carriages in train: #{train_1.number_of_carriages}"
