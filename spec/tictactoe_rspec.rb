require_relative '../lib/message'
require_relative '../lib/tictactoe'
require_relative '../lib/player'


describe TicTacToe do 

  subject(:game) { described_class.new }
  let(:player) { double(Player) }

  describe '#create_player' do 

      player_name = 'Matt'
      player_symbol = 'X'
      message_name = 'player_name'

    before do 
      allow(game).to receive(:puts)
      allow(game).to receive(:display_message).with(message_name)
      allow(game).to receive(:gets).and_return(player_name)
      allow(game).to receive(:symbol_checker).and_return(player_symbol)
    end 

    it 'Creates player #1' do
      expect(Player).to receive(:new).with(player_name, player_symbol)
      game.create_player(1)
    end
  end

  describe '#symbol_checker' do
    
    context 'Checks for valid user input' do

      player = 'Matt'
      player_symbol = 'X'
      invalid_symbol = 'X'
      valid_symbol = 'O'
      message_name = 'invalid_symbol'

      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:display_message).with(player_symbol)
        allow(game).to receive(:gets).and_return(invalid_symbol, valid_symbol)
      end 

      it 'Does not allow the same symbol as player 1' do
        expect(game).to receive(:symbol_checker).once
        game.symbol_checker(2, player_symbol, player)
      end 
    end
  end

  describe '#valid_position?' do

    context 'only allows input 1-9' do

      it 'returns true when input is = 1-9' do
        valid = 1
        expect(game).to receive(:valid_position?).and_return true
        game.valid_position?(valid)
      end

      it 'returns false when input is not = 1-9' do
        invalid = 12
        expect(game).to receive(:valid_position?).and_return false
        game.valid_position?(invalid)
      end

      it 'returns false when input is not a number' do
        invalid = 'a'
        expect(game).to receive(:valid_position?).and_return false
        game.valid_position?(invalid)
      end 
    end
  end

  describe '#turn_tracker' do

    context "continues game until it's over" do
      before do
        allow(game).to receive(:game_over?).and_return(false, false, false, true)
      end 
      it 'stops loop when game is over' do
        expect(game).to receive(:turn).exactly(4).times
        game.turn_tracker
      end 

      after do 
        allow(game).to receive(:turn_tracker)
      end 
    end 
  end

  describe '#turn_end' do

      player = Player.new('Matt', 'X')
      selects = 1

      before do
        allow(game.turn_end(player, selects))
        allow(game).to receive(:display)
      end
      it 'updates the board with player selection' do
          expect(game.board[selects - 1]).to eq 'X'
          game.turn_end(player, selects)
        end 
  end

  describe '#win?' do 

    context 'when there is a winning combo' do

      before do 
        game.instance_variable_set(:@board, ['X', 'X', 'X', 3, 4, 5, 6, 7, 8, 9])
      end 

      it 'returns true' do 
        expect(game.win?).to eq true 
      end
    end

    context 'when there is not a winning combo' do

      it 'returns false' do
        expect(game.win?).to eq false
      end
    end
  end

  describe '#board_full?' do 

    context 'Checks to see if the board is full' do

      it 'returns false when board is not full' do
        expect(game.board_full?).to eq false
      end 

      it 'returns true when full' do 
        game.instance_variable_set(:@selected, [true, true, true, true, true, true, true, true, true])
        expect(game.board_full?).to eq true
      end
    end
  end




end