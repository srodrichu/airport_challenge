require 'weather_api'

class TrafficInterface
    def initialize(weather)
        @weather = weather
    end

    def request_land(plane, airport)
        check_weather
        if airport.has_capacity
          airport.land_plane(plane)
        else
          fail "#{airport.get_name} is full"
        end
    end

    def request_takeoff(plane, airport)
        check_weather
        airport.take_off(plane)
    end

    private

    def check_weather
        fail "Weather is stormy, can't take-off" if @weather.check_weather == :stormy
    end
end