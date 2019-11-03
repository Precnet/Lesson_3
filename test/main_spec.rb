require 'rspec'
require_relative '../main.rb'

describe 'UserInterface' do
  context 'creating and selecting new menu items' do
    before(:each) do
      @ui = UserInterface.new
      @ua = UserActions.new
      @ui.create_menu_item('Show existing stations', lambda { @ua.show_existing_stations })
      @ui.create_menu_item('Create new station', -> (station) { @ua.create_station station})
    end
    it 'should add new stations' do
      expect { @ui.select_menu_item('Create new station', 'test') }.to output("Created station: test\n").to_stdout
    end
    it 'should show all created stations' do
      expect { @ui.select_menu_item('Show existing stations') }.to output("There are no stations.\n").to_stdout
      @ui.select_menu_item('Create new station', 'one')
      expect { @ui.select_menu_item('Show existing stations') }.to output("There are next stations:\none\n").to_stdout
      @ui.select_menu_item('Create new station', 'two')
      @ui.select_menu_item('Create new station', 'three')
      expect { @ui.select_menu_item('Show existing stations') }.to output("There are next stations:\none, two, three\n").to_stdout
    end
    it 'should create new trains' do
      @ui.create_menu_item('Create new passenger train', -> { @ua.create_passenger_train })
      @ui.create_menu_item('Create new cargo train', -> { @ua.create_cargo_train })
      @ui.create_menu_item('Show existing trains', -> { @ua.show_existing_trains })
      expect { @ui.select_menu_item('Show existing trains') }.to output("There are no trains.\n").to_stdout
      @ui.select_menu_item('Create new passenger train')
    end
  end
end