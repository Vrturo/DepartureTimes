get '/' do

  @transit = CalTrain.new
  @transit.display_departures


  erb :index
end
