class DepartureTime

  attr_accessor :departuretime, :departure
  def initialize(stopcode)
    @departuretime = []
    @stopcode = stopcode
    departuretimelink = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{ENV['TRANSIT_API_KEY']}&stopcode=#{@stopcode}"
    @departure = HTTParty.get(departuretimelink)
  end

  def get_stops
      @departure["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"].each do |hash|





        if hash.has_key?("RouteDirectionList")
          if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"] != nil
            if hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"].count < 1
                hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].each do |time|
                  @departuretime << "Minutes till next Departure: " + time
                end
            end
          end
        elsif hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"].count >= 1
            @departuretime << "Minutes till next Departure: " + hash["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]["DepartureTimeList"]["DepartureTime"]
        else
          next
        end




      puts @departuretime
    end #each
  end #method
end #class
