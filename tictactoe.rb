# frozen_string_literal: true

require_relative 'custom_variables'

class TicTakToe
  include CustomVariables

  attr_reader :player1, :player2, :player1_name, :player2_name, :board

  WIN = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [0, 4, 8], [1, 4, 7],
    [2, 5, 8], [2, 4, 6]
  ].freeze

  def initialize
    @player1 = 'X'
    @player2 = 'O'
    @player1_name = 'Matt'
    @player2_name = 'Jess'
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @selected = [false, false, false, false, false, false, false, false, false]
    game
  end

  def game
    instructions
    names
    player1_choose_symbol
    player2_choose_symbol
    display
    player1_move
    player2_move
  end

  def instructions
    puts <<-HEREDOC

    Lets play a simple game of Tic Tak Toe in the console.
    Players will choose a symbol and then take turns selecting
    where they would like to place their symbol on the board!

    When it's your turn choose your place on the board by typing in
    the number displayed on the board and that number will be replaced
    with your symbol! Simple as that!
    HEREDOC
    display
  end

  def display
    puts <<-HEREDOC

            #{board[0]} | #{board[1]} | #{board[2]}
           ---+---+---
            #{board[3]} | #{board[4]} | #{board[5]}
           ---+---+---
            #{board[6]} | #{board[7]} | #{board[8]}

    HEREDOC
  end

  def player1_move
    puts "#{player1_name} make your move!"
    selection = gets.chomp.to_i
    if (1..9).include?(selection)
      index_number = selection - 1
      if @selected[index_number] == false
        @board[index_number] = @player1
        @selected[index_number] = true
      else
        puts 'Please choose an open spot.'
        player1_move
      end
    else
      puts 'Try again, please select an open spot 1-9 (:'
      player1_move
    end
    display
    if win == true
      puts 'Would you like to play again?
      (type y to start over / any other key followed by enter to end)'
      answer = gets.chomp
      answer == 'y' ? initialize : exit
    end
    puts board_full?
    player2_move unless win == true
  end

  def player2_move
    puts "#{player2_name} make your move!"
    selection = gets.chomp.to_i
    if (1..9).include?(selection)
      index_number = selection - 1
      if @selected[index_number] == false
        @board[index_number] = @player2
        @selected[index_number] = true
      else
        puts 'Please choose an open spot.'
        player2_move
      end
    else
      puts 'Would you like to play again?
        (type y to start over / any other key followed by enter to end)'
      player2_move
    end
    display
    if win == true
      puts 'Would you like to play again? (y / n)'
      answer = gets.chomp
      answer == 'y' ? initialize : exit
    end
    puts board_full?
    player1_move unless win == true
  end

  def win
    WIN.any? do |combination|
      case [board[combination[0]],
            [board[combination[1]], [board[combination[2]]]]].flatten
      when [@player1, @player1, @player1]
        puts "#{@player1_name} Wins!"
        return true
      when [@player2, @player2, @player2]
        puts "#{@player2_name} Wins!"
        return true
      end
    end
  end

  def board_full? 
    full = @selected.all? { |values| values == true ? true : false }
    if full == true and win != true 
      puts 'It was a tie!'
      puts 'Would you like to play again? (y / n)'
      answer = gets.chomp
      answer == 'y' ? initialize : exit 
    end 
  end
end

new_game = TicTakToe.new