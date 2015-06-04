class  Admin::CitiesController < AdminController
  load_resource :only => [:edit, :update, :destroy]

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    @city.save!
    redirect_to admin_cities_path, :notice => 'City was successfully created.'
  end

  def destroy
    @city.destroy
    redirect_to admin_cities_path, notice: 'City was successfully destroyed.'
  end

  def edit
  end

  def update
    @city.update(city_params)
    redirect_to admin_cities_path, notice: 'City was successfully updated.'
  end

  private

  def city_params
    params.require(:city).permit(:name, :latitude, :longitude)
  end

end