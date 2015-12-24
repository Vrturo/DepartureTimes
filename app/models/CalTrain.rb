class CalTrain

  attr_accessor :departuretime, :stopcode, :stopname
  def initialize
    @agency_name = "Caltrain"
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
    hash = self.get_stops_for_routes
    arr = []
    second_arr = []
    third_arr = []
    self.get_stops_for_routes.each do |stop_code_hash|
        stop_code_hash["RTT"]["AgencyList"]["Agency"].each do |array| #array of values
          arr << array
        end
        flattened_arr = arr.flatten!
        flattened_arr.each do |item|
          if item.class == Hash
            second_arr << item
          else
            next
          end
          second_arr.each do |k, v|
            k["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |item|
              third_arr << item["StopCode"]
            end
          end
        end
      end
      stop_code_departuretime = []
      third_arr.uniq.each do |stop_code|
        stop_code_departuretime_link = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{stop_code}"
        stop_code_departuretime << HTTParty.get(stop_code_departuretime_link)
      end
      stop_code_departuretime
  end #method

  def display_departures
    route_hash_arr = []
    second_arr = []
    third_arr = []
    self.get_next_departuretime_by_code.each do |stop_code_hash|
       route_hash_arr << stop_code_hash["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]
    end
    ap route_hash_arr
        # flattened_arr = arr.flatten!
        # flattened_arr.each do |item|

        #   if item.class == Hash
        #     second_arr << item
        #   else
        #     next
        #   end
          # second_arr.find {|x| x["Route"] }

            # k["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |item|
              # third_arr << item["StopCode"]
            # end
        # end
    # end
     # pp route_hash_arr
    # third_arr
    # hash_flatten second_arr
  end #method



end #class








      # code_departure = HTTParty.get(stop_code_departuretime_link)

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
    # end #each
         # hash
