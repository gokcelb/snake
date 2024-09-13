require "./lib/snake/game"

height = 30
width = 90

game = Snake::Game.new
game.create_map(height, width, with_visible_borders: true)
game.create_food_spawner
game.add_snake
game.play
