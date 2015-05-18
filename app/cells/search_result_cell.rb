class SearchResultCell < BaseCell
  
  def row
    render
  end

  def show_link
    @path = "/admin/#{model.type.pluralize}/" + model.id.to_s
    render
  end
end