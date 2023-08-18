require_relative 'map/grid'
require_relative 'map/tile'

height = 30
width = 90
grid = Map::Grid.new(height, width)

(1..height).each do |y|
  (1..width).each do |x|
    representation = ' '

    representation = '|' if x == 1 || x == width
    representation = '-' if y == 1 || y == height

    grid.add_tile(Map::Tile.new(x, y, representation))
  end
end

grid.render