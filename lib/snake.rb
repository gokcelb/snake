require_relative "map/grid"

height = 30
width = 90

grid = Map::Grid.new(height, width)
grid.create_borders("|", "-")
grid.render
