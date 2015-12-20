get '/' do

  agencylink = "http://services.my511.org/Transit2.0/GetAgencies.aspx?token=#{ENV['TRANSIT_API_KEY']}"
  agency = HTTParty.get(agencylink)
  agency_arr = []
  agency["RTT"]["AgencyList"]["Agency"].each do |key|
    if key["HasDirection"] == "True"
      agency_arr << key
    end
  end
  @agency_arr = agency_arr



  routeforagencylink = "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=#{ENV['TRANSIT_API_KEY']}&agencyName=BART"
  @routeagency = HTTParty.get(routeforagencylink)
  route_name = []
  route_code = []
  @routeagency["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |key|
    route_name << key["Name"]
    route_code << key["Code"]
  end
  @route_name = route_name
  @route_code = route_code

  bartlink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?token=#{ENV['TRANSIT_API_KEY']}&routeIDF=BART~917"




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


  erb :index
end
