module Map
  class Tile
    attr_reader :x, :y, :representation

    def initialize(x, y, representation)
      @x = x
      @y = y
      @representation = representation
    end
  end
end