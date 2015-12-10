def transit_api_key
  ENV['TRANSIT_API_KEY']
end

def transit_api_url
  "http://services.my511.org/Transit2.0/GetStopsForRoutes.aspx?token=#{transit_api_key}&routeIDF=WestCAT~10~LOOP|BART~917"
end
