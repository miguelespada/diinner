class TestSelector
  
  def self.get_random_test(user)
    Test.not_in(id: user.get_test_response_ids).sample
  end
end