class Location < ActiveRecord::Base
  after_validation :geocode, :if => :address_changed?
  after_validation :reverse_geocode

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city    = geo.city
      obj.country = geo.country_code
    end
  end

  def name
    self.title or self.address
  end
end
