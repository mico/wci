class EventsController < ApplicationController
  def index
    @events = Event.where(:location_id => params[:location_id])

  end

  def show
  end
end
