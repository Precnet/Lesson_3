class UserInterface

  def initialize
    @stations = []
  end

  private

  def create_station(station_name)
    station = Station.new(station_name)
    @stations.push(station)
  end

  def show_existing_stations

  end

end
