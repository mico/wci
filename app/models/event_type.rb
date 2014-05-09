class EventType < ActiveRecord::Base
  def name
    self.alias
  end
end
