class UserCell < Cell::ViewModel

  private

  def method_missing(m, *args, &block)  
    render m
  end  
end
