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

  it "logout successfully" do 
    user = create(:user, email: "test@123", password: "123456")
    token = user.authentication_token

    post "logout" , params: { auth_token: token}
    
    expect(response).to have_http_status(200)
    user.reload
    expect(user.authentication_token).not_to eq(token)

  end

  it "login via facebook access_token" do
    user = create(:user, email: "test@123", password: "123456")
    fb_data = { "id" => "123", "email" => "test@123", "name" => "spy"}
    fb_access_token = "test123"
    auth_hash = double('OmniAuth::AuthHash')

    allow(User).to receive(:get_facebook_user_data).with(fb_access_token).and_return(fb_data)
    allow(OmniAuth::AuthHash).to receive(:new).and_return(auth_hash)
    allow(User).to receive(:from_omniauth).with(auth_hash).and_return(user)

    post "login", params: { access_token: fb_access_token }

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)).to eq({
      'message' => 'Login successfully.',
      'auth_token' => user.authentication_token
    })
  end
end
