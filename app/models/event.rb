class Event < ActiveRecord::Base
  validates_presence_of :title
  #has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  has_and_belongs_to_many :teachers
  belongs_to :event_type
  belongs_to :location

  mount_uploader :asset, AssetUploader
  # don't forget those if you use :attr_accessible (delete method and form caching method are provided by Carrierwave and used by RailsAdmin)
end
