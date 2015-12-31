

def route_conditional_method(route)
  if route.class == Array
    route.each do |route_direction_list_k, route_direction_list_v|
     route_direction_list_k["RouteDirection"]
    end
  else
    route["RouteDirectionList"]["RouteDirection"]
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
