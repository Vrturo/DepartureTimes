class Bart

 attr_accessor :departuretime
  def initialize(routecode)
    @departuretime = []
    @routecode = routecode
    departuretimelink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&routeIDF=BART~#{@routecode}"
    @departure = HTTParty.get(departuretimelink)
  end

  def get_stops
    @departure
  end
end
