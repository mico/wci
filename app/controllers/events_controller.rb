class EventsController < ApplicationController
  def index
    locations = [Location.find(params[:location_id])]
    locations += locations.first.nearbys(5)
    @events = Event.where(:location_id => locations)
    @location = locations.first
    #@events = Event.where(:location_id => params[:location_id])

  end

  def show
  end
end
