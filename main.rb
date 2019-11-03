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

  def create_cargo_train(train_number=nil)
    train_number ? @trains.push(CargoTrain.new(train_number)) : @trains.push(CargoTrain.new)
    puts "New cargo train created. Its number is: #{@trains[-1].train_number}"
  end

  def create_passenger_train(train_number=nil)
    train_number ? @trains.push(PassengerTrain.new(train_number)) : @trains.push(PassengerTrain.new)
    puts "New passenger train created. Its number is: #{@trains[-1].train_number}"
  end

  def show_existing_trains
    if @trains.length > 0
      passenger_trains = @trains.map{ |train| train.train_number if train.train_type == 'passenger'}
      puts 'There are next passenger trains: ' + passenger_trains.compact.join(',')
      cargo_trains = @trains.map{ |train| train.train_number if train.train_type == 'cargo'}
      puts 'There are next cargo trains: ' + cargo_trains.compact.join(',')
    else
      puts 'There are no trains.'
    end
  end

  def create_route(first_station, last_station)

  end

  def add_station_to_route(route, station)

  end

  def remove_station_from_route(route, station)

  end
end
