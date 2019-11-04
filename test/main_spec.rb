require 'rspec'
require_relative '../main.rb'

describe 'UserInterface' do
  context 'creating and selecting new menu items' do
    before(:each) do
      @ui = UserInterface.new
      @ud = UserData.new
      @ua = UserActions.new(@ud)
      @ui.create_menu_item('Show existing stations', lambda { @ua.show_existing_stations })
      @ui.create_menu_item('Create new station', -> (station) { @ua.create_station station})
    end
    it 'should add new stations' do
      message = "Created station: test\n"
      expect { @ui.select_menu_item('Create new station', 'test') }.to output(message).to_stdout
    end
    it 'should show all created stations' do
      message_1 = "There are no stations.\n"
      expect { @ui.select_menu_item('Show existing stations') }.to output(message_1).to_stdout
      @ui.select_menu_item('Create new station', 'one')
      message_2 = "There are next stations:\none\n"
      expect { @ui.select_menu_item('Show existing stations') }.to output(message_2).to_stdout
      @ui.select_menu_item('Create new station', 'two')
      @ui.select_menu_item('Create new station', 'three')
      message_3 = "There are next stations:\none, two, three\n"
      expect { @ui.select_menu_item('Show existing stations') }.to output(message_3).to_stdout
    end
    it 'should create new trains' do
      @ui.create_menu_item('Create new passenger train', -> (number=nil) { @ua.create_passenger_train number})
      @ui.create_menu_item('Create new cargo train', -> (number=nil) { @ua.create_cargo_train number})
      @ui.create_menu_item('Show existing trains', -> { @ua.show_existing_trains })
      expect { @ui.select_menu_item('Show existing trains') }.to output("There are no trains.\n").to_stdout
      message_1 = "New passenger train created. Its number is: test\n"
      expect { @ui.select_menu_item('Create new passenger train', 'test') }.to output(message_1).to_stdout
      message_2 = "New cargo train created. Its number is: 1234\n"
      expect { @ui.select_menu_item('Create new cargo train', '1234') }.to output(message_2).to_stdout
      @ui.select_menu_item('Create new cargo train', '4321')
      @ui.select_menu_item('Show existing trains')
      message_3 = "There are next passenger trains: test\nThere are next cargo trains: 1234,4321\n"
      expect { @ui.select_menu_item('Show existing trains') }.to output(message_3).to_stdout
    end
  end
  context 'route management' do
    before(:all) do
      @ui = UserInterface.new
      @ud = UserData.new
      @ua = UserActions.new(@ud)
      @ui.create_menu_item('Show existing stations', lambda { @ua.show_existing_stations })
      @ui.create_menu_item('Create new station', -> (station) { @ua.create_station station})
      @ui.create_menu_item('Create new route', -> (first, last, number=nil) {@ua.create_route(first, last, number)})
      @ui.create_menu_item('Add station to route', -> (route, station) {@ua.add_station_to_route(route, station)})
      @ui.create_menu_item('Remove station from route', -> (route, station) {@ua.remove_station_from_route(route, station)})
    end
    it 'should create new routes' do
      @ui.select_menu_item('Create new station', 'first')
      @ui.select_menu_item('Create new station', 'last')
      message = "Route 'test' created\n"
      expect { @ui.select_menu_item('Create new route', [@ud.stations['first'], @ud.stations['last'], 'test']) }.to output(message).to_stdout
      expect(@ud.routes.length).to eq(1)
      @ui.select_menu_item('Create new route', [@ud.stations['last'], @ud.stations['first']])
      expect(@ud.routes.length).to eq(2)
    end
    it 'should add stations to routes' do
      @ui.select_menu_item('Create new station', 'new_1')
      route_name = @ud.routes.keys.first
      station_name = @ud.stations.keys.last
      expect { @ui.select_menu_item('Add station to route', [route_name, 'new_1']).to raise_error(ArgumentError) }
      expect { @ui.select_menu_item('Add station to route', ['some_route', station_name]).to raise_error(ArgumentError) }
      message = "Station #{station_name} were added to route #{route_name}\n"
      expect { @ui.select_menu_item('Add station to route', [route_name, station_name]) }.to output(message).to_stdout
      expect(@ud.routes[route_name].stations.length).to eq(3)
      expect(@ud.routes[route_name].stations[-2].station_name).to eq('new_1')
    end
    it 'should delete stations from route' do
      @ui.select_menu_item('Create new station', 'middle_1')
      @ui.select_menu_item('Create new station', 'middle_2')
      route_name = @ud.routes.keys.first
      @ui.select_menu_item('Add station to route', [route_name, 'middle_1'])
      @ui.select_menu_item('Add station to route', [route_name, 'middle_2'])
      expect(@ud.routes[route_name].stations.length).to eq(5)
      expect { @ui.select_menu_item('Remove station from route', [route_name, 'new_2']) }.to raise_error(ArgumentError)
      expect { @ui.select_menu_item('Remove station from route', ['route_name', 'new_1']) }.to raise_error(ArgumentError)
      message = "Station 'new_1' were removed from route '#{route_name}'\n"
      expect { @ui.select_menu_item('Remove station from route', [route_name, 'new_1']) }.to output(message).to_stdout
      expect(@ud.routes[route_name].stations.length).to eq(4)
      @ui.select_menu_item('Remove station from route', [route_name, 'middle_1'])
      @ui.select_menu_item('Remove station from route', [route_name, 'middle_2'])
      expect(@ud.routes[route_name].stations.length).to eq(2)
    end
  end
end
