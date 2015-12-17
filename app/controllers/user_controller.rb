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

  getnextdeplink = "http://services.my511.org/Transit2.0/GetNextDeparturesForStopName.aspx?token=#{ENV['TRANSIT_API_KEY']}&agencyName=BART&Name=Dublin/Pleasanton"
  @getnextdep = HTTParty.get(getnextdeplink)










  stopsLink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~SB1&token=#{ENV['TRANSIT_API_KEY']}"
  stops = HTTParty.get(stopsLink)
  stopname = stops["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"][0]["name"]
  transit_arr = []
  stop_arr = []
  stops["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |key|
    transit_arr << key["name"]
    stop_arr << key["StopCode"]
  end
  @transit_arr = transit_arr
  @stop_arr = stop_arr

  getDepartureLink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{@stop_arr[0]}"
  @departure = HTTParty.get(getDepartureLink)

  erb :index
end
