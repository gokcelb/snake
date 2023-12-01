require "./lib/snake/game"

height = 30
width = 90

game = Snake::Game.new
game.create_map(height, width, with_visible_borders: true)
game.add_player
game.add_food_to_random_position
game.play
