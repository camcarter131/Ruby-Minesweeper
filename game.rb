require_relative "board"

class Game
    def initialize(board)
        @board = board
        @won = false
        @lost = false
    end

    def take_turn
        @board.render
        puts "Reveal or flag? ('r' or 'f')"
        move_type = gets.chomp
        puts 'Row: '
        pick_row = gets.chomp.to_i
        puts 'Column: '
        pick_col = gets.chomp.to_i

        system "clear"
        if (pick_row < 0 || pick_row >= @board.size) || (pick_col < 0 || pick_col >= @board.size)
            puts 'Please enter valid row and column'
            return
        end

        if move_type == 'r'
            @board.tiles[pick_row][pick_col].revealed = true
            @board.tiles[pick_row][pick_col].check_adjacent_tiles
        elsif move_type == 'f'
            @board.tiles[pick_row][pick_col].flagged = true;
        else 
            puts "Please enter valid move type ('r' or 'f')"
            return 
        end
        
    end

    def game_over?
        # @board.tiles.all? { |tile| tile.reavealed if !tile.bombed } ||
        # @board.tiles.any? { |tile| tile.revealed if tile.bombed }

        @board.tiles.each_with_index do |row, i|
            row.each_with_index do |col, j|
                if @board.tiles[i][j].bombed && @board.tiles[i][j].revealed 
                    @lost = true
                    return true
                end
            end
        end
        @board.tiles.each_with_index do |row, i|
            row.each_with_index do |col, j|
                if !@board.tiles[i][j].bombed && !@board.tiles[i][j].revealed 
                    return false 
                end
            end
        end
        @won = true
        true
    end

    def start
        while !game_over?
            take_turn
        end
        @board.render
        if @won
            puts 'You win!'
        elsif @lost 
            puts 'You lose'
        end
    end
end

board = Board.new(3)
game = Game.new(board)
game.start