class Tile
    attr_accessor :bombed, :flagged, :revealed
    attr_reader :neighbors, :position

    def initialize(board, position)
        @board = board;
        @position = position;
        @bombed = false;
        @flagged = false;
        @revealed = false;

        @neighbors = [];
        find_neighbors
    end

    def find_neighbors
        [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |shift|
            new_row, new_col = @position[0]+shift[0], @position[1]+shift[1]
            if ((new_row >= 0 && new_row < @board.size) && (new_col >= 0 && new_col < @board.size))
                @neighbors << @board.tiles[new_row][new_col]
            end
        end
    end

    def reveal
        @revealed = true;
    end

    def render 
        if flagged
            print 'F'
        elsif revealed && !bombed
            print '_'
        elsif revealed && bombed
            print 'B'
        else 
            print '*'
        end
        print ' '
    end

end