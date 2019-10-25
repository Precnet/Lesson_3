class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def show_route
    puts 'Route: ' + @stations.join(' => ')
  end

  def add_station(new_station)
    # check for duplication
    duplicate_station_message = 'Can`t add duplicate stations to the route!'
    raise ArgumentError, duplicate_station_message if @stations.find_index(new_station)
    @stations.insert(-2, new_station)
  end

  def delete_station(station)
    raise ArgumentError, "There is no station #{station} in current route!" unless there_is_such_station?(station)
    @stations.delete_at(@stations.find_index(station))
  end

  def there_is_such_station?(station)
    @stations.include? station
  end

end

# route = Route.new('first', 'last')
# route.show_route
#
# route.add_station('second')
# route.show_route
# route.add_station('third')
# route.show_route
# error
# route.add_station('second')
