class MapPresenter
  def initialize(users)
    @users = users
  end

  def url(width, height, centre=[0,0])
    "#{base_url}?sensor=false&size=#{width}x#{height}&markers=#{encode_markers}&center=#{centre.join(",")}"
  end

  private

  def base_url
    "https://maps.googleapis.com/maps/api/staticmap"
  end

  # This is really expensive... should it be?
  def encode_markers
    locations = @users.map do |user|
      next unless user.latlong?
      user.latlong.join(",")
    end

    return "size:tiny|color:0cE33052|#{locations.join("|")}"
  end

end
