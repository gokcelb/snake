require "./lib/snake/map"

height = 30
width = 90

grid = Snake::Map::Grid.new(height, width)
grid.create_borders("|", "-")
grid.render
