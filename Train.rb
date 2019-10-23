class Train
  attr_reader :train_number, :train_type

  def initialize(train_type, train_number_length=10)
    # nice little magick with converting int to str with Base36
    @train_number = rand(36 ** train_number_length).to_s(36)

    # check train type
    @train_type = check_train_type(train_type)

  end

  def check_train_type(train_type)
    errorMessage = "Wrong type of a train! Should be 'cargo' or 'passenger'. Got - '#{train_type}'"
    raise ArgumentError, errorMessage unless %w(passenger cargo).include? train_type
    train_type
  end
end

train_1 = Train.new('cargo')
puts train_1.train_number
puts train_1.train_type