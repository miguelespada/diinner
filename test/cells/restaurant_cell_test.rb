require 'test_helper'

class RestaurantCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select 'p'
  end


end
