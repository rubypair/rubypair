require 'faraday'
require 'json'

class Geocoder
  def initialize
    @connection = Faraday.new(:url => "https://maps.googleapis.com")
  end

  # arguments: location - an address
  # returns [lat, lon] - mongodb prefers this format for geospatial indexes
  def geocode!(location)
    response = @connection.get("/maps/api/geocode/json?sensor=false&address=#{location}")
    json = JSON.parse(response.body)

    if json["status"] == "OK"
      first_result = json["results"].first["geometry"]
      [first_result["location"]["lat"], first_result["location"]["lng"]]
    else
      nil
    end
  end
end
