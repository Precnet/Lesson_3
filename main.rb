class UserInterface

  def initialize
    @menu_items = {}
    @stations = []
  end

  def create_menu_item(item, command)
    @menu_items[item] = command
  end

  def select_menu_item(item)
    raise ArgumentError, "No such menu item: #{item}!" unless @menu_items.keys.include?(item)
    @menu_items[item].call
  end

  def create_station(station_name)
    station = Station.new(station_name)
    @stations.push(station)
    puts "Created station: #{station_name}"
  end

  def show_existing_stations
    if @stations.length > 0
      puts 'There are next stations:'
      puts ', '.join(@stations)
    else
      puts 'There are no stations.'
    end
  end

end
