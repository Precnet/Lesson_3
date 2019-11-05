class UserInterface
  def initialize
    @menu_items = {}
  end

  def create_menu_item(item, command)
    @menu_items[item] = command
  end

  def select_menu_item(item, args=nil)
    raise ArgumentError, "No such menu item: #{item}!" unless @menu_items.keys.include?(item)
    args ? @menu_items[item].call(*args) : @menu_items[item].call
  end
end

class UserActions

  def initialize(user_data)
    @user_data = user_data
  end

  def create_station(station_name)
    station = Station.new(station_name)
    @user_data.stations[station.station_name] = station
    puts "Created station: #{station.station_name}"
  end

  def show_existing_stations
    if @user_data.stations.length > 0
      puts 'There are next stations:'
      puts @user_data.stations.keys{ |station_name| station_name }.join(', ')
    else
      puts 'There are no stations.'
    end
  end

  def create_cargo_train(train_number=nil)
    train = train_number ? CargoTrain.new(train_number) : CargoTrain.new
    @user_data.trains[train.train_number] = train
    puts "New cargo train created. Its number is: #{train.train_number}"
  end

  def create_passenger_train(train_number=nil)
    train = train_number ? PassengerTrain.new(train_number) : PassengerTrain.new
    @user_data.trains[train.train_number] = train
    puts "New passenger train created. Its number is: #{train.train_number}"
  end

  def show_existing_trains
    if @user_data.trains.length > 0
      passenger_trains = @user_data.trains.select { |number, train| train.train_type == 'passenger'}.keys
      puts 'There are next passenger trains: ' + passenger_trains.compact.join(',')
      cargo_trains = @user_data.trains.select { |train_number, train| train.train_type == 'cargo'}.keys
      puts 'There are next cargo trains: ' + cargo_trains.compact.join(',')
    else
      puts 'There are no trains.'
    end
  end

  def create_route(first, last, route_number=nil)
    no_such_station_message = 'There are no station with such name.'
    stations_exist = @user_data.stations.keys.include?(first.station_name) && @user_data.stations.keys.include?(last.station_name)
    raise ArgumentError, no_such_station_message unless stations_exist
    if route_number
      route = Route.new(first, last, route_number)
    else
      route = Route.new(first, last)
    end
    @user_data.routes[route.route_number] = route
    puts "Route '#{route.route_number}' created"
  end

  def add_station_to_route(route_name, station_name)
    check_route_existence(route_name)
    check_station_existence(station_name)
    @user_data.routes[route_name].add_station(@user_data.stations[station_name])
    puts "Station #{station_name} were added to route #{route_name}"
  end

  def remove_station_from_route(route_name, station_name)
    check_route_existence(route_name)
    check_station_existence(station_name)
    @user_data.routes[route_name].delete_station(@user_data.stations[station_name])
    puts "Station '#{station_name}' were removed from route '#{route_name}'"
  end

  def add_route_to_train(route_name, train_number)
    check_route_existence(route_name)
    check_train_existence(train_number)
    @user_data.trains[train_number].set_route(@user_data.routes[route_name])
    puts "Train '#{train_number}' is following route '#{route_name} now'"
  end

  def add_carriage_to_train(train_number)
    check_train_existence(train_number)
    carriage_type = @user_data.trains[train_number].train_type
    carriage = carriage_type == 'cargo' ? CargoCarriage.new : PassengerCarriage.new
    @user_data.trains[train_number].add_carriage(carriage)
    puts "#{carriage_type.capitalize} carriage was added to train '#{train_number}'"
  end

  def remove_carriage_from_train(train_number, carriage_number)
    check_train_existence(train_number)
    check_train_has_such_carriage(train_number, carriage_number)
    @user_data.trains[train_number].remove_carriage(carriage_number)
    puts "Carriage '#{carriage_number}' was removed from train '#{train_number}'"
  end

  def move_train_forward(train_number)
    check_train_existence(train_number)
    @user_data.trains[train_number].move_forward
  end

  def move_train_backward(train_number)
    check_train_existence(train_number)
    @user_data.trains[train_number].move_backward
  end

  private
  def check_route_existence(route_name)
    raise ArgumentError, "No such route #{route_name}" unless @user_data.routes.keys.include? route_name
  end

  def check_station_existence(station_name)
    raise ArgumentError, "No such station #{station_name}" unless @user_data.stations.keys.include? station_name
  end

  def check_train_existence(train_name)
    raise ArgumentError, "No such train #{train_name}" unless @user_data.trains.keys.include? train_name
  end

  def check_train_has_such_carriage(train_number, carriage_number)
    error_message = "Train '#{train_number}' has no carriages with number '#{carriage_number}'"
    has_carriage = @user_data.trains[train_number].carriages.map{|carriage| carriage.carriage_number}.include?(carriage_number)
    raise ArgumentError, error_message unless has_carriage
  end
end

class UserData
  attr_accessor :stations, :trains, :routes
  def initialize
    @stations = {}
    @trains = {}
    @routes = {}
  end
end
