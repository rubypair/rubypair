require 'test_helper'
require 'geocoder'

describe Geocoder do
  let (:geocoder) { Geocoder.new }

  describe "#geocode!" do
    it "should geocode a location" do
      VCR.use_cassette("geocode-edinburgh") do
        result = geocoder.geocode!("Edinburgh, UK")
        result.should == [55.9501755, -3.1875359]
      end
    end

    it "shouldn't raise errors when used with the user class" do
      VCR.use_cassette("geocode-user") do
        -> {
          user = Factory.build(:user)
          ll = geocoder.geocode!(user.location)
          user.latlong = ll
        }.should_not raise_error
      end
    end
  end



end
