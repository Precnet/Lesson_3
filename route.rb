class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end
  def add_station(new_station)
    # check for duplication
    duplicate_station_message = 'Can`t add duplicate stations to the route!'
    raise ArgumentError, duplicate_station_message if @stations.find_index(new_station)
    @stations.insert(-2, new_station)
  end
  def delete_station(station)
    raise ArgumentError, "There is no station #{station} in current route!" unless @stations.include? station
    @stations.delete_at(@stations.find_index(station))
  end
end
