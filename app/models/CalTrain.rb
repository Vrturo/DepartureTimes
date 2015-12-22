class CalTrain

  attr_accessor :departuretime, :stopcode, :stopname
  def initialize
    @agency_name = "Caltrain"
  end

  def get_route
    agency_link = "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=#{ENV['TRANSIT_API_KEY']}&agencyName=#{@agency_name}"
    routes = HTTParty.get(agency_link)
    route_code_hash = {route_codes: []}
    route_direction_code_arr = []
    routes["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |route|
      #set route name as keys
      # route_code = route["Code"]
      route_code_hash[:route_codes] << {route["Code"] => []} # set route[Code] as a new hash that stores an array

    # end
    # routes["RouteDirectionList"]["RouteDirection"].each do |route_direction|
        # p route_direction["Code"]
         # route_direction_code_arr << route_direction["Code"]
      # end
    end
    route_code_hash
  end

  def get_stops_for_routes
    self.get_route
    route_code_arr.each do |route_code|
      route_direction_code_arr.each do |route_direction|
        stops_for_routes_link = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?token=#{ENV['TRANSIT_API_KEY']}&routeIDF=#{@agency_name}~#{route_code}~#{route_direction}"
        stops = HTTParty.get(stops_for_routes_link)

      end
    end
  end



  def get_stops_by_name(stopname)
    @stopname = stopname.delete(" ") #delete white space for html request
    stopname_departuretime = []
    stop_name_departuretime_link = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopName.aspx?token=#{ENV['TRANSIT_API_KEY']}&agencyName=Caltrain&stopName=#{@stopname}"
    name_departure = HTTParty.get(stop_name_departuretime_link)


    if name_departure["RTT"]["AgencyList"]["Info"].include?("No Predictions Available")
      "No stops within the next 90 minutes"
      @name_departure
    else
      "There are stops available!"
    end

  end

  def get_stops_by_code(stopcode)
    stopcode_departuretime = []
    stop_code_departuretime_link = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{stopcode}"
    code_departure = HTTParty.get(stop_code_departuretime_link)
    code_departure#["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each_with_index do |hash, index|

      # if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].nil?
      #   @stopcode_departuretime << "No departures within the next hour"
      #   next
      # else
      #   if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].class == Array
      #       hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each do |time|
      #         @stopcode_departuretime << "Stop #{index + 1}: Minutes till next Departure: " + time
      #       end
      #     next
      #   elsif hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].class == String
      #       @stopcode_departuretime << "Stop #{index + 1}: Minutes till next Departure: " + hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"]
      #     next
      #   else
      #     @stopcode_departuretime << "Stop #{index + 1}: No departures within the next hour"
      #   end
      # end

      # return @stopcode_departuretime.join("<br>")
  # end #each
  end #method

end #class
