class DepartureTime

  attr_accessor :departuretime, :departure
  def initialize(stopcode)
    @departuretime = []
    @stopcode = stopcode
    departuretimelink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{@stopcode}"
    @departure = HTTParty.get(departuretimelink)
  end

  def get_stops
      @departure["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |hash|
        if hash.has_key?("RouteDirectionList")
          if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"] != nil
            hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].each do |time|
                @departuretime << "Minutes till next Departure: " + time.flatten!.to_s
            end
          else
            next
          end
        else
          next
        end
      end
      puts @departuretime
    end
end
