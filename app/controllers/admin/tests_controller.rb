class  Admin::TestsController < AdminController

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

  private

  def test_params
    params.require(:test).permit(:question)
  end

end