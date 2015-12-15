get '/' do

  agencyLink = "http://services.my511.org/Transit2.0/GetAgencies.aspx?token=#{ENV['TRANSIT_API_KEY']}"
  agency = HTTParty.get(agencyLink)

  agency_arr = []
  agency["RTT"]["AgencyList"]["Agency"].each do |key|
    if key["Mode"] == "Rail"
      agency_arr << key
    end
  end
  @agency_arr = agency_arr


  getStopsLink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~SB1&token=#{ENV['TRANSIT_API_KEY']}"
  @data = HTTParty.get(getStopsLink)

  @stopname =  @data["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"][0]["name"]

  transit_arr = []
  @data["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |key|
    transit_arr << key["name"]
  end
  @transitarr = transit_arr

  getDepartureLink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode="



  erb :index
end
