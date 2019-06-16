class Tile
    attr_accessor :bombed, :flagged, :revealed
    attr_reader :neighbors

    def initialize(board, position)
        @board = board;
        @position = position;
        @bombed = false;
        @flagged = false;
        @revealed = false;

        @neighbors = [];
        [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |shift|
            if (position[0]+shift[0] >= 0 && position[0]+shift[0] < board.size && position[1]+shift[1] >= 0 && position[1]+shift[1] < board.size)
                @neighbors << board.tiles[position[0]+shift[0], position[1]+shift[1]]
            end
        end
    end

    def reveal
        @revealed = true;
    end

    def render 
        if @flagged
            p 'F'
        elsif @revealed
            p '_'
        else 
            p '*'
        end
    end

end