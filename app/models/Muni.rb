class Muni

 attr_accessor :departuretime
  def initialize(routecode, routedirectioncode)
    @departuretime = []
    @routecode = routecode
    @routedirectioncode = routedirectioncode
    departuretimelink = "http://services.my511.org/Transit2.0//GetStopsForRoute.aspx?token=#{ENV['TRANSIT_API_KEY']}&routeIDF=SF-MUNI~#{@routecode}~#{@routedirectioncode}"
    @departure = HTTParty.get(departuretimelink)
  end

  def get_stops
    @departure
  end
end
