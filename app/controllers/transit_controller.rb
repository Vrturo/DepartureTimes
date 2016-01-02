get '/' do

  @transit = CalTrain.new
  @transit.display_departures


  # Making an array of just the stop names to the map.js file
  stop_name_arr = []
  @transit.stop_name.each do |stop_name|
    stop_name_arr << stop_name[:name]
  end
  #multiple stops cause stop names to come up more than once
  # but we only need the stop name one time to display in map
  @stop_name_arr = stop_name_arr.uniq!

  erb :index
end
