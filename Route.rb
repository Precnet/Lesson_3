class Route
  def initialise(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def show_route
    puts @stations.join(' => ')
  end
end
