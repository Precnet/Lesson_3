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
    it 'should create new routes' do
      @ui.select_menu_item('Create new station', 'first')
      @ui.select_menu_item('Create new station', 'last')
      @ui.create_menu_item('Create new route', -> (first, last, number=nil) {@ua.create_route(first, last, number)})
      message = "Route 'test' created\n"
      expect { @ui.select_menu_item('Create new route', [@ud.stations['first'], @ud.stations['last'], 'test']) }.to output(message).to_stdout
      expect(@ud.routes.length).to eq(1)
      @ui.select_menu_item('Create new route', [@ud.stations['last'], @ud.stations['first']])
      expect(@ud.routes.length).to eq(2)
    end
  end
end
