class IndexController < ApplicationController
  def index
    @festival = EventType.find_by_alias(:festival).events.first;
    @events = EventType.find_by_alias(:workshop).events.limit(3);
  end
end
