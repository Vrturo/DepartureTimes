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
    second_arr = []
    # third_arr = []
    self.get_stops_for_routes.each do |stop_code_hash|
        arr = stop_code_hash["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]
    end

    # arr
          # arr = k
    #     end
    #     flattened_arr = arr.flatten!
    #     flattened_arr.each do |item|
    #       if item.class == Hash
    #         second_arr << item
    #       else
    #         next
    #       end
    #       second_arr.each do |k, v|
    #         k["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |item|
    #           third_arr << item["StopCode"]
    #         end
    #       end
    #     end
      # end
    #   stop_code_departuretime = []
    #   third_arr.uniq.each do |stop_code|
    #     stop_code_departuretime_link = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{stop_code}"
    #     stop_code_departuretime << HTTParty.get(stop_code_departuretime_link)
      # end
      ap arr
    #   stop_code_departuretime
  end #method

  def display_departures
    route_hash_arr = []
    departures = []
    third_arr = []

    self.get_next_departuretime_by_code.each do |transit_hash|
      transit_hash["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |route_direction_array| #5 hash objects
        route_hash_arr = route_direction_array
        # route_direction_array.each do |key, value|
        #     if key == ["RouteDirection"]
        #     stopname = key["RouteDirection"]["StopList"]["Stop"]["Name"]

            # if key["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].nil?
            #   departures << "No departures within the next hour"
            # else
            #   if key["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].class == Array
            #        key["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each_with_index do |time, index|
            #           departures << "Stop #{index + 1}: Minutes till next Departure: " + time
            #        end
            #      next
            #   elsif key["RouteDirection"]["StopList"]["Stop"]["DepartureTime"].class == String
            #         departures << "Stop 1: Minutes till next Departure: " + key["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"]
            #     next
            #   else
            #     departures << "Stop #{index + 1}: No departures within the next hour"
            #   end
            # end
            # route_direction = key["RouteDirection"]["Name"]


            # route_hash_arr == { stopname => { route_direction => departures }}
            # route_hash_arr << key["RouteDirection"]["Name"]
          # end
        # end
      end
      route_hash_arr.each do |k, v|
        third_arr << k
      end
    end
     ap route_hash_arr
     ap third_arr

  end #method
  #example output
    # self.stop_name
    # self.route_direction_name
    # self.departuretime
    # ["So San Francisco Caltrain Station","SOUTHBOUND TO TAMIEN, DepartureTime: 11]

end #class


# {"RouteDirectionList"=>
#   {"RouteDirection"=>
#     {"StopList"=>
#       {"Stop"=>
#         {"DepartureTimeList"=>nil,
#         "name"=>"College Park Caltrain Station",
#         "StopCode"=>"70252"}
#         }, #Stop

#       "Code"=>"SB3",
#       "Name"=>"SOUTHBOUND TO GILROY"}
#       }, #stoplist

#     "Name"=>"LOCAL", #routedirection
#     "Code"=>"LOCAL"}

