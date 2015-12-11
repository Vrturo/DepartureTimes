get '/' do

  htmllink = 'http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~SB1&token=58cb6407-ebd8-4d7d-894c-27da1e56e7e3'
  @data = HTTParty.get(htmllink)

  @stopname =  @data["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"][0]["name"]

  erb :index
end
