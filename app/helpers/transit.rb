

def route_conditional_method(route)
  if route.class == Array
    route.each do |route_direction_list_k, route_direction_list_v|
     return route_direction_list_k["RouteDirectionList"]["RouteDirection"]
    end
  else
    return route["RouteDirectionList"]["RouteDirection"]
  end
end


def route_direction_conditional_method(stop_list)
  if stop_list.class == Array
    stop_list.each do |stop_k, stop_v|
      self.route_direction_name = stop_k["Name"]
     return stop_k["StopList"]["Stop"]["DepartureTimeList"]
    end
  else
    return stop_list["StopList"]["Stop"]["DepartureTimeList"]
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
