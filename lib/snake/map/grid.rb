require "./lib/snake/map/tile"
require "./lib/snake/player"

module Snake
  module Map
    class Grid
      attr_reader :height, :width, :tiles

      def initialize(height, width)
        @height = height
        @width = width
        @tiles = []

        fillin_tiles
      end

      def create_borders(vertical_representation, horizontal_representation)
        @tiles.each do |tile|
          next unless tile.on_edge?(@height, @width)

          representation = vertical_representation if tile.on_vertical_edge?(@width)
          representation = horizontal_representation if tile.on_horizontal_edge?(@height)
          tile.representation = representation
        end
      end

      def update_tile_representation(x, y, representation)
        tile = find_tile(x, y)
        tile.representation = representation
      end

      def render
        system("clear")
        @tiles.each { |t| print "#{t.representation}#{(t.x % @width == 0) ? "\n" : nil}" }
      end

      private

      def fillin_tiles
        (1..@height).each { |y| (1..@width).each { |x| @tiles << Tile.new(x, y) } }
      end

      def find_tile(x, y)
        @tiles.find { |t| t.x == x && t.y == y }
      end
    end
  end
end
