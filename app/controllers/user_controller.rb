get '/' do

  # Hit the get agency query so I could see my possible public transportation agencies I could choose from
  agencylink = "http://services.my511.org/Transit2.0/GetAgencies.aspx?token=#{ENV['TRANSIT_API_KEY']}"
  agency = HTTParty.get(agencylink)
  agency_arr = []
  agency["RTT"]["AgencyList"]["Agency"].each do |key|
    if key["HasDirection"] == "True"
      agency_arr << key
    end
  end
  @agency_arr = agency_arr #get list of all public transportation with route


  northboundlink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LIMITED~NB&token=#{ENV['TRANSIT_API_KEY']}"
  @northbound = HTTParty.get(northboundlink)
  northbound_arr = []
  northstop_arr = []
  @northbound["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |key|
    northbound_arr << key["name"]
    northstop_arr << key["StopCode"]
  end
  @northbound_arr = northbound_arr #array of northbound names
  @northstop_arr = northstop_arr  #array of northbound stop codes

  southboundlink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LIMITED~SB1&token=#{ENV['TRANSIT_API_KEY']}"
  @southbound = HTTParty.get(southboundlink)
  southbound_arr = []
  southstop_arr = []
  @southbound["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"].each do |key|
    southbound_arr << key["name"]
    southstop_arr << key["StopCode"]
  end
  @southbound_arr = southbound_arr
  @southstop_arr = southstop_arr


  erb :index
end
