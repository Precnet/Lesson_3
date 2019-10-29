class PassengerTrain < Train
  attr_reader :carriages

  def initialize
    super(train_type='passenger', number_of_carriages=0)
    @carriages = []
  end
end
