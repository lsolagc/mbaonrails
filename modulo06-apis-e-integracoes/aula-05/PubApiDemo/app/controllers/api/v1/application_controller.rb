class Api::V1::ApplicationController < ActionController::API
  before_action :authenticate_token

  def authenticate_token
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)
    if decoded
      user_data = decoded.first
      decoded_jti = user_data["jti"]
      user = User.find_by(id: user_data["user_id"])
      if user.current_jti == decoded_jti
        @current_user = user
      else
        render json: { error: "Unauthorized" }, status: :unauthorized and return
      end
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
