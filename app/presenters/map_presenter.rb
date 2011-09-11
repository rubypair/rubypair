class MapPresenter

  attr_reader :users

  def initialize(users)
    @users = users
    # This is really expensive... should it be?
    @users.select! {|user| user.latlong? }
  end

  def url(width, height, centre=[0,0])
    "#{base_url}?sensor=false&size=#{width}x#{height}&#{encode_markers}&center=#{centre.join(",")}"
  end

  private

  def base_url
    "https://maps.googleapis.com/maps/api/staticmap"
  end

  # This is really expensive... should it be?
  def encode_markers
    locations = @users.map do |user|
      user.latlong.join(",")
    end

    return "markers=size:tiny|color:0cE33052|#{locations.join("|")}"
  end

end
