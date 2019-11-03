require 'rspec'
require_relative '../main.rb'

describe 'UserInterface' do
  context 'creating and selecting new menu items' do
    it 'should add new stations' do
      ui = UserInterface.new
      ui.create_menu_item('Create new station', lambda { ui.create_station('test') })
      expect { ui.select_menu_item('Create new station') }.to output("Created station: test\n").to_stdout
    end
    it 'should show all created stations' do
      ui = UserInterface.new
      expect { ui.show_existing_stations }.to output("There are no stations.\n").to_stdout
      ui.create_station('one')
      expect { ui.show_existing_stations }.to output("There are next stations:\none\n").to_stdout
      ui.create_station('two')
      ui.create_station('three')
      expect { ui.show_existing_stations }.to output("There are next stations:\none, two, three\n").to_stdout
    end
  end
end