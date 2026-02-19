class TokensController < ApplicationController
  def create
    user = Current.user
    new_jti = SecureRandom.uuid
    user.update!(current_jti: new_jti)

    payload = {
      user_id: user.id,
      jti: new_jti
    }
    @token = JsonWebToken.encode(payload)

    respond_to do |format|
      format.turbo_stream { render :create }
    end
  end
end
