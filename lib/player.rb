# frozen_string_literal: true

class Player

  attr_reader :player_name, :player_symbol

  def initialize(player_name, player_symbol=nil)
    @player_name = player_name
    @player_symbol = player_symbol
  end 
end
