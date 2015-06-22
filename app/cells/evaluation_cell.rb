class EvaluationCell < BaseCell
  property :comments

  def user
    cell(:user, model.reservation.user)
  end
end