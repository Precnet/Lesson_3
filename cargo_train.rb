require_relative 'train.rb'

class CargoTrain < Train
  attr_reader :carriages

  def initialize
    super(train_type='cargo', number_of_carriages=0)
    @carriages = []
  end

  def add_carriage(carriage)
    raise RuntimeError, 'Can`t add new carriages while train is moving.' unless @current_speed == 0
    error_message = "Wrong carriage for this type of train. Expected 'CargoCarriage', got #{carriage.class}."
    raise ArgumentError, error_message unless carriage_correct?(carriage)
    carriages.push(carriage)
  end

  def remove_carriage(carriage)
    error_message = 'There are no carriages to remove.'
    raise ArgumentError, error_message unless @carriages.length > 0
    @carriages.delete_at(-1)
  end

  private

  def carriage_correct?(carriage)
    carriage.respond_to?(:carriage_type) && carriage.carriage_type == 'cargo'
  end

end
