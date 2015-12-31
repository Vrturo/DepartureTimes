

def route_conditional_method(route)
  if route.class == Array
    route.each do |route_direction_list_k, route_direction_list_v|
     return route_direction_list_k["RouteDirectionList"]["RouteDirection"]
    end
  else
    return route["RouteDirectionList"]["RouteDirection"]
  end
end


def route_direction_conditional_method(route_direction)
  if route_direction.class == Array
    ap 'array'
  else
    ap 'hash'
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
