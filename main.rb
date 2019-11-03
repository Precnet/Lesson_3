class UserInterface
  def initialize
    @menu_items = {}
  end

  def create_menu_item(item, command)
    @menu_items[item] = command
  end

  def select_menu_item(item, argument=nil)
    raise ArgumentError, "No such menu item: #{item}!" unless @menu_items.keys.include?(item)
    argument ? @menu_items[item].call(argument) : @menu_items[item].call
  end
end

class UserActions

  def initialize
    # dont really like to store it here. In ideal world there would be a separate class for it
    @stations = []
    @trains = []
  end

  def create_station(station_name)
    station = Station.new(station_name)
    @stations.push(station)
    puts "Created station: #{station.station_name}"
  end

  def show_existing_stations
    if @stations.length > 0
      puts 'There are next stations:'
      puts @stations.map{ |station| station.station_name }.join(', ')
    else
      puts 'There are no stations.'
    end
  end

  def create_cargo_train

  end

  def create_passenger_train
    @trains.push PassengerTrain.new
    puts "New passenger train created. Its number is: #{@trains[-1].train_number}"
  end
end
