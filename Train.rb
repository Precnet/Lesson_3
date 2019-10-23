class Train
  attr_accessor :number_of_carriages
  attr_reader :train_number, :train_type, :current_speed

  def initialize(train_type, number_of_carriages, train_number = generate_train_number(10))
    # nice little magick with converting int to str with Base36
    @train_number = train_number
    @number_of_carriages = number_of_carriages
    # check train type
    @train_type = check_train_type(train_type)

    @current_speed = 0
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
      puts "Train is at it`s maximum speed - 120kmh. It can`t increase it`s speed any more."
    end
    current_speed
  end

  private :check_train_type, :generate_train_number
end

train_1 = Train.new('cargo', 10)
puts "Train number: #{train_1.train_number}"
puts "Train type: #{train_1.train_type}"
puts "Number of carriages in train: #{train_1.number_of_carriages}"
