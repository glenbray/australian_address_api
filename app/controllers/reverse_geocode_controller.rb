class ReverseGeocodeController < ActionController::API
  def index
    @addresses = Address.reverse_geocode(params[:lng], params[:lat], params[:within])
  end
end
