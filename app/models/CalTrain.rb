class CalTrain

  attr_accessor :departuretime, :stopcode, :stopname
  def initialize(stopname, stopcode)
    @stopname_departuretime = []
    @stopcode_departuretime = []
    @stopname = stopname.delete(" ") #delete white space for html request
    @stopcode = stopcode
    stop_name_departuretime_link = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopName.aspx?token=#{ENV['TRANSIT_API_KEY']}&agencyName=Caltrain&stopName=#{@stopname}"
    stop_code_departuretime_link = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{@stopcode}"
    @name_departure = HTTParty.get(stop_name_departuretime_link)
    @code_departure = HTTParty.get(stop_code_departuretime_link)
  end

  def get_stops_by_name

    if @name_departure["RTT"]["AgencyList"]["Info"].include?("No Predictions Available")
      "No stops within the next 90 minutes"
    else
      "Stops!"
    end

  end

  def get_stops_by_code
      @stopcode_departure["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each_with_index do |hash, index|

        if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].nil?
          @stopcode_departuretime << "No departures within the next hour"
          next
        else
          if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].class == Array
              hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each do |time|
                @stopcode_departuretime << "Stop #{index + 1}: Minutes till next Departure: " + time
              end
            next
          elsif hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].class == String
              @stopcode_departuretime << "Stop #{index + 1}: Minutes till next Departure: " + hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"]
            next
          else
            @stopcode_departuretime << "Stop #{index + 1}: No departures within the next hour"
          end
        end

        return @stopcode_departuretime.join("<br>")
    end #each
  end #method

end #class
