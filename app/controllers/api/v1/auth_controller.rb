class Api::V1::AuthController < ApiController
  before_action :authenticate_user!, only: :logout
  
  def login
    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
    end 

    if user && user.valid_password?(params[:password])
      render json: {
        message: "Login successfully.",
        auth_token: user.authentication_token
      }
    else
      render json: { message: "Email or Password is wrong"} , status: 401
    end 
  end

  def logout
    current_user.genrate_authentication_token
    current_user.save!

    render json: { message: "Logout successfully."}
  end
end
