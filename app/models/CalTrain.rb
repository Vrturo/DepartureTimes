class CalTrain

  attr_accessor :departuretime
  def initialize(stopcode)
    @departuretime = []
    @stopcode = stopcode
    departuretimelink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{@stopcode}"
    @departure = HTTParty.get(departuretimelink)
  end

  def get_stops
      @departure["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each_with_index do |hash, index|

        if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].nil?
          @departuretime << "No departures within the next hour"
        else
          if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].class == Array
              hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each do |time|
                @departuretime << "Stop #{index + 1}: Minutes till next Departure: " + time
              end
            next
          elsif hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].class == String
              @departuretime << "Stop #{index + 1}: Minutes till next Departure: " + hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"]
            next
          else
            @departuretime << "Stop #{index + 1}: No departures within the next hour"
          end
        end

        return @departuretime.join("<br>")
    end #each
  end #method
end #class
