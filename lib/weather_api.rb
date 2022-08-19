class WeatherAPI
    def initialize(io = Kernel)
        @io = io
    end

    def check_weather
        @io.rand(100) > 80 ? :stormy : :clear
    end
end
