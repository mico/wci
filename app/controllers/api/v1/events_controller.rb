class Api::V1::EventsController < ApplicationController
  respond_to :json

  def index
    respond_with Event.all
  end

  # def index
  #   locations = [Location.find(params[:location_id])]
  #   locations += locations.first.nearbys(5)
  #   @events = Event.where(:location_id => locations)
  #   @location = locations.first
  # end

  def show
  end

  private

  def story_params
    params.require(:event).permit(:title, :description)
  end

end
