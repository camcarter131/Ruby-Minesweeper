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
        seed_bombs
    end

    def seed_bombs
        @tiles.each_with_index do |row, i|
            row.each_with_index do |col, j|
                @tiles[i][j].bombed = true if rand(3) == 0
            end
        end
    end

    # def (pos)
    #     @tiles[pos[0], pos[1]]
    # end

    def render
        @tiles.each_with_index do |row, i|
            row.each_with_index do |col, j|
                @tiles[i][j].render
                puts '' if j == @size - 1
            end
        end
    end

end
