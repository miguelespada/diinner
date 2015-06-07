class Admin::PaymentsController < AdminController
  load_resource :only => [:show]

  def index
    @payments = Payment.desc(:created_at).page(params[:page])
  end

  def show
  end

end