get '/' do

  @transit = CalTrain.new
  @transit.display_departures

  stop_name_arr = []
  @transit.stop_name.each do |stop_name|
    stop_name_arr << stop_name[:name]
  end
  @stop_name_arr = stop_name_arr

  erb :index
end
