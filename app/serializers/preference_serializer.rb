class PreferenceSerializer < ActiveModel::Serializer
  attributes :min_age, :max_age, :menu_price, :city_id

  def city_id
    object.city.id.to_s
  end

end
