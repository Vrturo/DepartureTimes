

def route_conditional_method(route)
  if route.class == Array
    route.each do |route_direction_list_k, route_direction_list_v|
     return route_direction_list_k
     ap "array"
    end
  else
    return route["RouteDirectionList"]
  end
end


def route_direction_conditional_method(route_direction)

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
