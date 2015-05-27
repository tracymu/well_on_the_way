class ApplicationController < ActionController::API
  def check_api_key
    @api_key = ApiKey.find_by_key(params[:api_key])
    unless @api_key
      render nothing: true, status: :unauthorized
      false
    end
  end
end
