require_relative 'train.rb'

class PassengerTrain < Train
  attr_reader :carriages

  def initialize
    super(train_type='passenger', number_of_carriages=0)
    @carriages = []
  end

  def add_carriage(carriage)
    error_message = "Wrong carriage for this type of train. Expected 'PassengerCarriage', got #{carriage.class}."
    raise ArgumentError, error_message unless carriage_correct?(carriage)
    carriages.push(carriage)
  end

  private

  def carriage_correct?(carriage)
    carriage.carriage_type == 'passenger'
  end

end
