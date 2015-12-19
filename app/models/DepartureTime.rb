class DepartureTime

  attr_accessor :departuretime
  def initialize(stopcode)
    @departuretime = []
    @stopcode = stopcode
    departuretimelink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{@stopcode}"
    @departure = HTTParty.get(departuretimelink)
  end

  def get_stops
      @departure.keys.each_with_index do |(key,value), index|
          value = @departure[key]
           print "key: #{key}, value: #{value}, index: #{index}\n"
        # if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].nil?
        #   @departuretime << "Stop #{index + 1}: No departures within the next hour"
        # elsif hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].class == Array
        #     hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each do |time|
        #       @departuretime << "Stop #{index + 1}: Minutes till next Departure: " + time
        #     end
        # elsif hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].class == String
        #     @departuretime << "Stop #{index + 1}: Minutes till next Departure: " + hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"]
        # else
        #   @departuretime << "Stop #{index + 1}: No departures within the next hour"
        # end

        # return @departuretime.join("<br>")
    end #each
  end #method
end #class
