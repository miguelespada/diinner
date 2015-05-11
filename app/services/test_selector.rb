class TestSelector
    # TODO is this really a service?  
  def self.get_random_test(user)
    # TODO bad practice (argument)
    Test.not_in(id: user.get_test_response_ids, gender: user.opposite_sex).sample
  end
end