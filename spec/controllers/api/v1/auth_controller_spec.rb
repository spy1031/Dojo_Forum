require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  it "login via email and password" do
    user = create(:user, email: "test@123", password: "123456")
    post "login" , params: { email: user.email, password: user.password}

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)).to eq({
      "message" => 'Login successfully.',
      "auth_token" => user.authentication_token
    })
  end
end
