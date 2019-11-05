class PassengerCarriage
  NUMBER_LENGTH = 5
  BASE_36 = 36

  attr_reader :carriage_type, :carriage_number

  def initialize(carriage_number=generate_carriage_number(NUMBER_LENGTH))
    @carriage_type = 'passenger'
    @carriage_number = carriage_number
  end

  private
  def generate_carriage_number(number_length)
    @carriage_type + '_' + rand(BASE_36 ** number_length).to_s(BASE_36)
  end
end
