class AddressAutocompleteController < ActionController::API
  def index
    @addresses = Address.search(params[:q], match: :word_start)
  end
end
