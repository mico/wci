class EventType < ActiveRecord::Base
  has_many :events
  def name
    self.alias
  end
end
