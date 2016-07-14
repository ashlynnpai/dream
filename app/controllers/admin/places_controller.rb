class Admin::PlacesController < AdminsController
  before_filter :authenticate_user!
  before_filter :require_admin
  
  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to dashboard_path
  end
end