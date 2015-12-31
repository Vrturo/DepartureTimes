class CalTrain

  attr_accessor :departuretime, :route_direction_name, :stop_name
  def initialize
    @agency_name = "Caltrain"
    @stations = []
    @departuretime = []
    @route_direction_name = {}
    @stop_name = {}
  end

  def get_route
    agency_link = "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=#{ENV['TRANSIT_API_KEY']}&agencyName=#{@agency_name}"
    routes = HTTParty.get(agency_link)
    route_code_hash = {route_codes: []}
    routes["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |route|
      #set route name as keys
      route["RouteDirectionList"]["RouteDirection"].each do |route_direction|
        route_code_hash[:route_codes] << {route['Code'] => route_direction} # set route[Code] as a new hash that stores an array
        end
    end
    route_code_hash[:route_codes]
  end

  def get_stops_for_routes
    stops = []
    self.get_route.each do |route_code_hash| #[{"BABY BULLET" =>[...] }]
       route_code_hash.each do |route_code , code_direction|
          route_code = route_code.delete(" ") #delete spaces so it works fine in api call
          stops_for_routes_link = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?token=#{ENV['TRANSIT_API_KEY']}&routeIDF=#{@agency_name}~#{route_code}~#{code_direction['Code']}"
          stops <<  HTTParty.get(stops_for_routes_link)
        end
      end
      stops
  end

  def get_next_departuretime_by_code
    arr = []
    stopcode_arr = []
    self.get_stops_for_routes.each do |stop_code_hash| #weed out nil classes
        if stop_code_hash["RTT"]["AgencyList"]["Agency"]["RouteList"]
          arr << stop_code_hash["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]
        else
          next
        end
    end
    arr.each do |route_list_hash|
      route_list_hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |code|
        stopcode_arr << code["StopCode"]
      end
    end
      stop_code_departuretime = []
      stopcode_arr.uniq!
      stopcode_arr.each do |stop_code|
        stop_code_departuretime_link = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{stop_code}"
        stop_code_departuretime << HTTParty.get(stop_code_departuretime_link)
      end
      stop_code_departuretime
  end #method

  def display_departures
    self.get_next_departuretime_by_code.each do |transit_hash|
      transit_hash["RTT"]["AgencyList"]["Agency"]["RouteList"].each do |route_k, route_v| #5 hash objects

        route_direction = route_conditional_method(route_v)
        departure_time_list = route_direction_conditional_method(route_direction)
        departure_time = departure_time_list_conditional_method(departure_time_list)
      end
    end
  end #method
  #example output
    # self.stop_name
    # self.route_direction_name
    # self.departuretime
    # ["So San Francisco Caltrain Station","SOUTHBOUND TO TAMIEN, DepartureTime: 11]

end #class





