class SearchResultCell < BaseCell
  def row
    @path = "/admin/#{model.type.pluralize}/" + model.id.to_s
    render
  end
end