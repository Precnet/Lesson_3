require 'rspec'
require_relative '../main.rb'

describe 'UserInterface' do
  context 'creating and selecting new menu items' do
    it 'should add new stations' do
      ui = UserInterface.new
      ui.create_menu_item('Create new station', lambda { ui.create_station('test') })
      expect { ui.select_menu_item('Create new station') }.to output("Created station: test\n").to_stdout
    end
  end
end