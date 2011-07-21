class SessionsController < ApplicationController
  skip_before_filter :authorize


  # GET /sessions/new
  # GET /sessions/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end


  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id

    Twitter.configure do |config|
      config.consumer_key = '0DOxCtTOsWTdQQ3nrkbw'
      config.consumer_secret = 'HSZXSYSKczcsHsFeSRNKFGIi1Wqf8SCROsMB6NXA'
      config.oauth_token = user.token
      config.oauth_token_secret = user.secret
    end

    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
