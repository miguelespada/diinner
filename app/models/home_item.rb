class HomeItem
  include Mongoid::Document

  has_attachment :header, accept: [:jpg, :png, :gif]
  has_attachment :mobile_background, accept: [:jpg, :png, :gif]
  
  belongs_to :restaurant_sample_1, class_name: "Restaurant"
  belongs_to :restaurant_sample_2, class_name: "Restaurant"
  belongs_to :restaurant_sample_3, class_name: "Restaurant"

  def self.get_first
    HomeItem.first || HomeItem.create
  end
end