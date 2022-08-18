class TrafficInterface
    def initialize
    end

    def request_land(plane, airport)
        #if checks pass then land plane
        if airport.has_capacity
          airport.land_plane(plane)
        else
          fail "#{airport.get_name} is full"
        end
    end

    def request_takeoff(plane, airport)
      #if weather checks out
      airport.take_off(plane)
    end
end
