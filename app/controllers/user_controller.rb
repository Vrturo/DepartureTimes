get '/' do

  htmllink = 'http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~SB1&token=58cb6407-ebd8-4d7d-894c-27da1e56e7e3'
  doc = Nokogiri::HTML(open(htmllink))
  @doc = doc.to_s
  @hello = "hello there"

  response = HTTParty.get(htmllink)
  @data = response

  erb :index
end
