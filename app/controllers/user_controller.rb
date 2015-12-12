get '/' do

  htmllink = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~SB1&token=#{ENV['TRANSIT_API_KEY']}"
  @data = HTTParty.get(htmllink)

  @stopname =  @data["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"][0]["name"]

  erb :index
end
