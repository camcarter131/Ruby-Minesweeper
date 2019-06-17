class Tile
    attr_accessor :bombed, :flagged, :revealed, :numbered
    attr_reader :neighbors, :position

    def initialize(board, position)
        @board = board
        @position = position
        @bombed = false
        @flagged = false
        @revealed = false
        @numbered = 0

        find_neighbor_pos
    end

    def find_neighbor_pos
        @neighbors = [];
        [[-1, 0], [1, 0], [0, -1], [0, 1], [1,1], [-1,-1], [-1,1], [1,-1]].each do |shift|
            new_row, new_col = @position[0]+shift[0], @position[1]+shift[1]
            if ((new_row >= 0 && new_row < @board.size) && (new_col >= 0 && new_col < @board.size))
                # @neighbors << @board.tiles[new_row][new_col]
                @neighbors << [new_row, new_col]
            end
        end
    end

    def adjacent_bombs
        count = 0
        @board.tiles[@position[0]][@position[1]].neighbors.each do |n|
            count += 1 if @board.tiles[n[0]][n[1]].bombed
        end
        numbered = count
        count
    end

    def check_adjacent_tiles
        @neighbors.each do |pos|
            bomb_count = adjacent_bombs
            if bomb_count > 0
                @board.tiles[pos[0]][pos[1]].numbered = bomb_count if !@board.tiles[pos[0]][pos[1]].bombed
            end 
        end 
        if @neighbors.none? {|pos| @board.tiles[pos[0]][pos[1]].numbered > 0}
            @neighbors.each {|n_pos| @board.tiles[n_pos[0]][n_pos[1]].revealed = true}
        end
    end

    def reveal
        @revealed = true
    end

    def render 
        if flagged
            print 'F'
        elsif revealed && !bombed
            print '_'
        elsif revealed && bombed
            print 'B'
        elsif numbered > 0
            print numbered.to_s
        else 
            print '*'
        end
        print ' '
    end

end