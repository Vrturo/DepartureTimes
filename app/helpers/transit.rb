

def route_conditional_method(route)
  if route.class == Array
    route.each do |route_direction_list_k, route_direction_list_v|
     return route_direction_list_k["RouteDirectionList"]["RouteDirection"]
    end
  else #Hash
    return route["RouteDirectionList"]["RouteDirection"]
  end
end


def route_direction_conditional_method(stop_list)
  if stop_list.class == Array
    stop_list.each do |stop_k, stop_v|
      self.route_direction_name = stop_k["Name"]
      self.stop_name = stop_k["StopList"]["Stop"]["name"]
     return stop_k["StopList"]["Stop"]["DepartureTimeList"]
    end
  else #Hash
    self.route_direction_name = stop_list["Name"]
    self.stop_name = stop_list["StopList"]["Stop"]["name"]
    return stop_list["StopList"]["Stop"]["DepartureTimeList"]
  end
end

def departure_time_list_conditional_method(departure_time_list)
  if departure_time_list.nil?
    self.departuretime << "No departures within the next 90 minutes"
  else
      if departure_time_list["DepartureTime"].class == Array
        departure_time_list["DepartureTime"].each do |time|
          self.departuretime << "Minutes till next Departure: " + time
        end

      else #String
        self.departuretime << "Minutes till next Departure: " + departure_time_list["DepartureTime"]
      end
  end
end




# <RTT> {}
#     <AgencyList> {}
#         <Agency> {}
#             <RouteList> {}
#                 <Route> {} or []
#                     <RouteDirectionList> {}
#                         <RouteDirection {} or [] Name="SOUTHBOUND TO TAMIEN">
#                             <StopList> {}
#                                 <Stop {} name="College Park Caltrain Station">
#                                     <DepartureTimeList /> nil or {}
#                                       <DepartureTime> [] or ""
