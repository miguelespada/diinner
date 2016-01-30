class HomeItem
  include Mongoid::Document

  has_attachment :header, accept: [:jpg, :png, :gif]
  has_attachment :how_it_works_1, accept: [:jpg, :png, :gif]
  has_attachment :how_it_works_2, accept: [:jpg, :png, :gif]
  has_attachment :how_it_works_3, accept: [:jpg, :png, :gif]

  belongs_to :restaurant_sample_1, class_name: "Restaurant"
  belongs_to :restaurant_sample_2, class_name: "Restaurant"
  belongs_to :restaurant_sample_3, class_name: "Restaurant"

  def self.get_first
    HomeItem.first || HomeItem.create
  end
end