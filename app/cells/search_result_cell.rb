class SearchResultCell < BaseCell
  def show_link
    if admin_signed_in?
      @path = "/admin/#{model.type.pluralize}/" + model.id.to_s
      render
    end
  end
end