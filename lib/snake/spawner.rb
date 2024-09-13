module Snake
  class Spawner
    def initialize(map, object_klass)
      @map = map
      @object_klass = object_klass
    end

    def spawn(index = nil)
      object = @object_klass.new
      index = @map.random_position
      collided_object_type = @map.detect_collision(index)
      until collided_object_type.nil? do
        index = @map.random_position
        collided_object_type = @map.detect_collision(index)
      end
      @map.update(index, object)
    end
  end
end