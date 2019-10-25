class Station
  attr_reader :station_name, :trains_at_station

  def initialize(station_name)
    @station_name = check_station_name(station_name)
    @trains_at_station = []
    @train_numbers = []
  end

  def check_station_name(name)
    raise ArgumentError, 'Station name can`t be nil!' unless name
    raise ArgumentError, 'Station name should be of String class!' unless name.is_a?(String)
    raise ArgumentError, 'Station name can`t be empty!' unless name.length > 0
    raise ArgumentError, 'Station name is too long! Should be <= 20 symbols.' unless name.length <= 20
    name
  end

  def train_arrived(new_train)
    @trains_at_station.push(new_train)
    @train_numbers.push(new_train.train_number)
  end

  def trains_at_station_of_type(train_type)

  end

  def send_train(train_number)
    error_message = "There is no train with number '#{train_number}' at station"
    raise ArgumentError, error_message unless train_at_station?(train_number)

    @trains_at_station.delete_at(get_train_index_by(train_number))
  end

  def train_at_station?(train_number)
    @train_numbers.include? train_number
  end

  def get_train_index_by(train_name)
    @train_numbers.find_index(train_name)
  end

  private :check_station_name, :train_at_station?, :get_train_index_by
end