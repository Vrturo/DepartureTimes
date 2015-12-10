get '/' do

  p @response = HTTParty.get('http://services.my511.org/Transit2.0/GetAgencies.aspx?token=58cb6407-ebd8-4d7d-894c-27da1e56e7e3')
  erb :index
end
