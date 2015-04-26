class  Admin::TestsController < AdminController
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    @test.save!
    redirect_to admin_tests_path, :notice => 'Test was successfully created.'
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: 'Test was successfully destroyed.'
  end

  def edit
  end

  def update
    @test.update(test_params)
    redirect_to admin_tests_path, notice: 'Test was successfully updated.'
  end


  private

  def test_params
    params.require(:test).permit(:question)
  end

end