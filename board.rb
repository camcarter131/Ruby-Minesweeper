
class Board 
    def initialize(size) 
        @size = size;
        @tiles = Array.new(@size){Array.new(@size, 'X')}
    end



    def render
        @tiles.each do |tile| 
            p tile
        end
    end

end

board = Board.new(5);
board.render;