module Map
  class Grid
    attr_reader :tiles

    def initialize(height, width)
      @height = height
      @width = width
      @tiles = []
    end

    def add_tile(tile)
      @tiles << tile
    end

    def render
      @tiles.each { |t| print "#{t.representation}#{t.x % @width == 0 ? "\n" : nil}" }
    end
  end
end