class RestaurantCell < BaseCell
  include ActionView::Helpers::DateHelper
  include CloudinaryHelper

  property :name

  def city
    model.city.name if !model.city.nil?
  end

  def delete_link
    if admin_signed_in?
      @path = admin_restaurant_path(model)
      render
    end
  end

  def new_link
    if admin_signed_in?
      @path = new_admin_restaurant_path
      render
    end
  end

  def show_link
    if admin_signed_in?
      @path = admin_restaurant_path(model)
      render
    elsif model.is_owned_by?(current_restaurant)
      @path = restaurant_path(model)
      render
    elsif user_signed_in?
      @path = user_restaurant_path(current_user, model)
      render
    end
  end

  def edit_link
    if admin_signed_in?
      @path = edit_admin_restaurant_path(model)
      render
    elsif model.is_owned_by?(current_restaurant)
      @path = edit_restaurant_path(model)
      render
    end
  end

  def logout_link
    if restaurant_signed_in?
      @path = destroy_restaurant_session_path
      render
    end
  end

  def menus
    # TODO admin_restaurant_row???
    if admin_signed_in? || model.is_owned_by?(current_restaurant)
      table "Menus", \
          %w(Name Price), \
          cell(:menu, collection: model.menus, method: :admin_restaurant_row)
    end
  end

  def tables
    # TODO admin_restaurant_row???
    if admin_signed_in? || model.is_owned_by?(current_restaurant)
      table "Tables", \
          %w(Id Day Hour Left Status), \
          cell(:table, collection: model.tables, method: :admin_restaurant_row)
    end
  end

  def reservations
    # TODO admin_restaurant_row???
    if admin_signed_in? || model.is_owned_by?(current_restaurant)
      table "Reservations", \
          %w(Id User Menu Status), \
          cell(:reservation, collection: model.reservations, method: :admin_restaurant_row)
    end
  end

  def evaluations
    if admin_signed_in?
      table "Evaluations", \
          %w(Reservation User Comments, Fun?, Recommend?, Restaurant, Menu), \
          cell(:evaluation, collection: model.evaluations, method: :admin_row)
    end
  end

  def cl_photo size
     w = size
     h = w * 3 / 4
     cl_image_tag(model.photo.public_id, quality: 75, format: :jpg, size: "#{w}x#{h}", crop: :fill ) if model.photo.present?
  end

  def photo
    cl_image_tag(model.photo.public_id, width: 400, height: 300, crop: fill, quality: 75, format: :jpg) if model.photo.present?
  end

  private

  def status
    if admin_signed_in?
      "Last time active: " + (@model.current_sign_in_at.nil? ? "never" : time_ago_in_words( @model.current_sign_in_at )).to_s
    end
  end
end