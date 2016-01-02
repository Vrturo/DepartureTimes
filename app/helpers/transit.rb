def route_conditional_method(route)
  route_array = []
  if route.class == Array
    route.each do |route_direction_list_k, route_direction_list_v|
     route_array << route_direction_list_k["RouteDirectionList"]["RouteDirection"]
    end
  else #Hash
    route_array << route["RouteDirectionList"]["RouteDirection"]
  end
  return route_array
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
  departure_array = []
  if departure_time_list.nil?
    departure_array << "No departures within the next 90 minutes"
  else
      if departure_time_list["DepartureTime"].class == Array
        departure_time_list["DepartureTime"].each do |time|
         departure_array << "Minutes till next Departure: " + time
        end
      else #String
         departure_array << "Minutes till next Departure: " + departure_time_list["DepartureTime"]
      end
  end
  departure_array
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
