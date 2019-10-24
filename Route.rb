class Route
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def show_route
    puts 'Route: ' + @stations.join(' => ')
  end
end

route = Route.new('first', 'last')
route.show_route
