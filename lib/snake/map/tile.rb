module Snake
  module Map
    class Tile
      attr_reader :x, :y
      attr_accessor :representation

      def initialize(x, y)
        @x = x
        @y = y
        @representation = " "
      end

      def on_edge?(grid_height, grid_width)
        x == 1 || y == 1 || x == grid_width || y == grid_height
      end

      def on_vertical_edge?(grid_width)
        x == 1 || x == grid_width
      end

      def on_horizontal_edge?(grid_height)
        y == 1 || y == grid_height
      end
    end
  end
end
