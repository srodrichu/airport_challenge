class Airport
    def initialize(name, capacity = 50)
        @capacity = capacity
        @name = name
        @airplanes = []
    end
    
    attr_reader :capacity, :name

    def land_plane(plane)
        @airplanes << plane
    end

    def get_airplanes
        @airplanes
    end

    def take_off(plane)
      @airplanes.delete(plane)
    end
    
    def has_capacity
      @airplanes.length < @capacity
    end

    def get_name
      @name
    end
end
