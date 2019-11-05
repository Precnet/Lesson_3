require_relative 'train.rb'

class CargoTrain < Train
  attr_reader :carriages

  def initialize(train_number=nil)
    if train_number
      super(train_type='cargo', number_of_carriages=0, train_number=train_number)
    else
      super(train_type='cargo', number_of_carriages=0)
    end

    @carriages = []
  end

  def add_carriage(carriage)
    raise RuntimeError, 'Can`t add new carriages while train is moving.' unless @current_speed == 0
    error_message = "Wrong carriage for this type of train. Expected 'CargoCarriage', got #{carriage.class}."
    raise ArgumentError, error_message unless carriage_correct?(carriage)
    carriages.push(carriage)
  end

  def remove_carriage(carriage_number)
    error_message = 'There are no such carriages.'
    raise ArgumentError, error_message unless @carriages.map { |carriage| carriage.carriage_number }.include?(carriage_number)
    @carriages.reject! { |carriage| carriage.carriage_number == carriage_number }
  end

  def number_of_carriages
    @carriages.length
  end

  private

  def carriage_correct?(carriage)
    carriage.respond_to?(:carriage_type) && carriage.carriage_type == 'cargo'
  end

end
