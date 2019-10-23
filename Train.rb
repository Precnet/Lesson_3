class Train
  attr_accessor :number_of_carriages
  attr_reader :train_number, :train_type

  def initialize(train_type, number_of_carriages, train_number_length=10)
    # nice little magick with converting int to str with Base36
    @train_number = rand(36 ** train_number_length).to_s(36)

    @number_of_carriages = number_of_carriages

    # check train type
    @train_type = check_train_type(train_type)

  end

  def check_train_type(train_type)
    errorMessage = "Wrong type of a train! Should be 'cargo' or 'passenger'. Got - '#{train_type}'"
    raise ArgumentError, errorMessage unless %w(passenger cargo).include? train_type
    train_type
  end

  private :check_train_type
end

train_1 = Train.new('cargo', 10)
puts "Train number: #{train_1.train_number}"
puts "Train type: #{train_1.train_type}"
puts "Number of carriages in train: #{train_1.number_of_carriages}"
