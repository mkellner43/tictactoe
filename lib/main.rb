require_relative 'tictactoe'
require_relative 'player'
require_relative 'message'

def play_game
  game = TicTacToe.new
  game.start
  reset 
end 

def reset
  answer = gets.chomp
  answer == 'y' ? play_game : exit 
end 

play_game
