class ReverseGeocodeController < ActionController::API
  def index
    @addresses = Address.reverse_geocode(params[:lng], params[:lat])
  end
end
