# As an air traffic controller 
# To ensure safety 
# I want to prevent landing when weather is stormy

require 'plane'
require 'airport'
require 'traffic_interface'
require 'weather_api'

RSpec.describe "integration" do

    # As an air traffic controller 
    # So I can get passengers to a destination 
    # I want to instruct a plane to land at an airport 

    it "can instruct a plane to land at an airport" do
        airport1 = Airport.new("London")
        plane1 = Plane.new('001')
        plane2 = Plane.new('002')
        weather = double :weather
        interface = TrafficInterface.new(weather)
        expect(weather).to receive(:check_weather).and_return(nil)
        expect(weather).to receive(:check_weather).and_return(nil)
        interface.request_land(plane1, airport1)
        interface.request_land(plane2, airport1)

        expect(airport1.get_airplanes).to eq [plane1, plane2]
    end

    # As an air traffic controller 
    # So I can get passengers on the way to their destination 
    # I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport

    it "instructs a plane to takeoff and confirms its no longer in the airport" do
        airport1 = Airport.new("London")
        plane1 = Plane.new('001')
        plane2 = Plane.new('002')
        weather = double :weather
        interface = TrafficInterface.new(weather)
        airport1.land_plane(plane1)

        expect(airport1.get_airplanes).to eq [plane1]
        expect(weather).to receive(:check_weather).and_return(nil)
        interface.request_takeoff(plane1, airport1)

        expect(airport1.get_airplanes).to eq []
    end

    # As an air traffic controller 
    # To ensure safety 
    # I want to prevent landing when the airport is full 

    it "prevents landing when the airport is full" do
        airport1 = Airport.new("London", 1)
        weather = double :weather
        plane1 = Plane.new('001')
        plane2 = Plane.new('002')
        interface = TrafficInterface.new(weather)
        airport1.land_plane(plane1) 
        expect(weather).to receive(:check_weather).and_return(nil)
        expect { interface.request_land(plane2, airport1) }.to raise_error "London is full"
    end

    # As the system designer
    # So that the software can be used for many different airports
    # I would like a default airport capacity that can be overridden as appropriate

    it "can have an airport capacity than can be overriden as appropriate" do
      airport_with_capacity20 = Airport.new("Birmingham", 20)
      airport_with_default50 = Airport.new("London")

      expect(airport_with_capacity20.capacity).to eq 20
      expect(airport_with_default50.capacity).to eq 50
    end

    # As an air traffic controller 
    # To ensure safety 
    # I want to prevent takeoff when weather is stormy 

    it "prevents takeoff when weather is stormy" do
        io_dbbl = double :io
        airport = Airport.new("London")
        plane1 = Plane.new('001')
        weather = WeatherAPI.new(io_dbbl)
        interface = TrafficInterface.new(weather)
        airport.land_plane(plane1)

        expect(io_dbbl).to receive(:rand).with(100).and_return(85)
        expect{interface.request_takeoff(plane1, airport)}.to raise_error "Weather is stormy, can't take-off"
    end
end
