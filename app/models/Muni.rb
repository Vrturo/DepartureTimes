class Muni

 attr_accessor :departuretime, :stopname, :stopcode
  def initialize(routecode, routedirectioncode)
    @departuretime = []
    @stopname = []
    @stopcode = []
    @routecode = routecode
    @routedirectioncode = routedirectioncode
    departuretimelink = "http://services.my511.org/Transit2.0//GetStopsForRoute.aspx?token=#{ENV['TRANSIT_API_KEY']}&routeIDF=SF-MUNI~#{@routecode}~#{@routedirectioncode}"
    @departure = HTTParty.get(departuretimelink)
  end

  def get_stopcode_and_name
    @departure["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |key|
      @stopname << key["name"]
      @stopcode << key["StopCode"]
    end
  end

  def show_stops
    self.get_stopcode_and_name
    @stopcode
    HTTParty.get("http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=13546")
  end

end
