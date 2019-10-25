class Station
  attr_reader :station_name, :trains_at_station

  def initialize(station_name)
    @station_name = check_station_name(station_name)
    @trains_at_station = []
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
  end

  def trains_at_station_of_type(train_type)

  end

  private :check_station_name
end