class Admin::PaymentsController < AdminController
  load_resource :only => [:show]

  def index
    @payments = Payment.all
  end

  def show
  end
end