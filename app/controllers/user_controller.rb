get '/' do

  agencylink = "http://services.my511.org/Transit2.0/GetAgencies.aspx?token=#{ENV['TRANSIT_API_KEY']}"
  agency = HTTParty.get(agencylink)
  agency_arr = []
  agency["RTT"]["AgencyList"]["Agency"].each do |key|
    if key["Name"] == "BART"
      agency_arr << key
    end
  end
  @agency_arr = agency_arr

  routeforagencylink = "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=#{ENV['TRANSIT_API_KEY']}&agencyName=BART"
  @routeagency = HTTParty.get(routeforagencylink)


  northboundlink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~NB&token=#{ENV['TRANSIT_API_KEY']}"
  @northbound = HTTParty.get(northboundlink)
  northbound_arr = []
  northstop_arr = []
  @northbound["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |key|
    northbound_arr << key["name"]
    northstop_arr << key["StopCode"]
  end
  @northbound_arr = northbound_arr #array of northbound names
  @northstop_arr = northstop_arr  #array of northbound stop codes

  southboundlink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~SB1&token=#{ENV['TRANSIT_API_KEY']}"
  @southbound = HTTParty.get(southboundlink)
  southbound_arr = []
  southstop_arr = []
  @southbound["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |key|
    southbound_arr << key["name"]
    southstop_arr << key["StopCode"]
  end
  @southbound_arr = southbound_arr
  @southstop_arr = southstop_arr

  # departuretimelink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=70041"
  # departuretime = []
  # @departure = HTTParty.get(departuretimelink)
  # @departure["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |hash|
  #   if hash.has_key?("RouteDirectionList")
  #     if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"] != nil
  #       hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each do |time|
  #         departuretime << "Minutes till next Departure: " + time
  #       end
  #   else
  #     next
  #   end
  #   else
  #     next
  #   end
  # end
  # @departuretime = departuretime

  erb :index
end
