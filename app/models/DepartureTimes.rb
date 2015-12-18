class DepartureTimes

  attr_accessor :departuretime
  def initialize(stopcode)
    @departuretime = []
    @stopcode = stopcode
    departuretimelink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{@stopcode}"
  end

  def get_stops
    @departuretime = []
    departure = HTTParty.get(departuretimelink)
      departure["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |hash|
        if hash.has_key?("RouteDirectionList")
          if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"] != nil
            hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each do |time|
              @departuretime << "Minutes till next Departure: " + time
            end
          else
            next
          end
        else
          next
        end
      end

    end
