class CargoCarriage
  NUMBER_LENGTH = 5
  BASE_36 = 36
  CARRIAGE_TYPE = 'cargo'

  attr_reader :carriage_type, :carriage_number

  def initialize(carriage_number=generate_carriage_number(NUMBER_LENGTH))
    @carriage_type = CARRIAGE_TYPE
    @carriage_number = carriage_number
  end

  private
  def generate_carriage_number(number_length)
    CARRIAGE_TYPE + '_' + rand(BASE_36 ** number_length).to_s(BASE_36)
  end
end
