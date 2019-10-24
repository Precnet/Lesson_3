class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def show_route
    puts 'Route: ' + @stations.join(' => ')
  end

  def add_station(new_station)
    @stations.insert(-2, new_station)
  end

end

route = Route.new('first', 'last')
route.show_route

route.add_station('second')
route.show_route
route.add_station('third')
route.show_route
