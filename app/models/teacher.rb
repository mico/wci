class Teacher < ActiveRecord::Base
  has_and_belongs_to_many :events
  def name
    id? and first_name + " " + last_name
  end

end
