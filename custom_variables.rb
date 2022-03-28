# frozen_string_literal: true

module CustomVariables
  def names
    puts 'Player 1, what is your name?'
    @player1_name = gets.chomp
    puts 'Player 2, what is your name?'
    @player2_name = gets.chomp
  end

  def player1_choose_symbol
    puts "#{player1_name} pick your symbol by typing in any key letter or number:"
    selection = gets.chomp
    selection.length == 1 ? @player1 = selection : player1_choose_symbol
  end

  def player2_choose_symbol
    puts "#{player2_name} pick your symbol by typing in any key letter or number:"
    selection2 = gets.chomp
    if selection2.downcase == @player1.downcase
      puts 'This is already taken pick a different symbol'
      player2_choose_symbol
    end
    selection2.length == 1 ? @player2 = selection2 : player2_choose_symbol
  end
end
