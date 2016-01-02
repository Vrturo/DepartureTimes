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
      dep_time = departure_time_list_conditional_method(stop_k["StopList"]["Stop"]["DepartureTimeList"])
      stop_hash = {name: stop_k["StopList"]["Stop"]["name"], route_direction: stop_k["Name"], departures: dep_time}
      self.stop_name << stop_hash
    end
  else #Hash
    dep_time = departure_time_list_conditional_method(stop_list["StopList"]["Stop"]["DepartureTimeList"])
    stop_hash = {name: stop_list["StopList"]["Stop"]["name"], route_direction: stop_list["Name"], departures: dep_time}
    self.stop_name << stop_hash
  end

end

def departure_time_list_conditional_method(departure_time_list)
  if departure_time_list.nil?
    return"No departures within the next 90 minutes"
    # self.departuretime << "No departures within the next 90 minutes"
  else
      if departure_time_list["DepartureTime"].class == Array
        departure_time_list["DepartureTime"].each do |time|
          return "Minutes till next Departure: " + time
        end

      else #String
        return "Minutes till next Departure: " + departure_time_list["DepartureTime"]
      end
  end
end


# Every condition possible

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
