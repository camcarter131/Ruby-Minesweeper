require_relative "tile"

class Board 
    attr_reader :size, :tiles

    def initialize(size) 
        @size = size;
        @tiles = Array.new(@size){Array.new(@size, 0)}
        @tiles.each_with_index do |row, i|
            row.each_with_index do |col, j|
                @tiles[i][j] = Tile.new(self, [i,j])
            end
        end
    end

    def render
        @tiles.each_with_index do |row, i|
            row.each_with_index do |col, j|
                @tiles[i][j].render
            end
        end
    end

end

board = Board.new(3);
board.render;