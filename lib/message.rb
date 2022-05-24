module Messages

  def display_message(message, player=nil)
    {
      'player1_name' => "\nPlayer 1, what is your name?",
      'player2_name' => "\nPlayer 2, what is your name?",
      'player_symbol' => "\n#{player} pick your symbol by typing in any letter or number",
      'player_turn' => "\n#{player} make your move!",
      'invalid_move' => "\n#{player} Invalid_move: Please choose an open spot 1-9 (:",
      'invalid_symbol' => "\nPlease choose a 1 letter symbol that hasn't already been selected.",
      'winner' => "\n#{player} Wins!!",
      'tie' => "\nIt was a tie!",
      'game_over' => "\nWould you like to play again? (type y to start over / any other key followed by enter to end)"
    }[message]
  end

end 

