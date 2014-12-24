require 'twilio-ruby'
class TwilioController < ApplicationController
  include Webhookable
  # after_filter :set_header
  skip_before_action :verify_authenticity_token
  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
      r.Play 'http://linode.rabasa.com/cantina.mp3'
    end
    render_twiml response
  end

  # def notify
  #   client = Twilio::REST::Client.new 'AC37a6bc10aed8d0298ae2cb1a6500ee8a', 'a2f4a6fd9f71a6f8c855157bab046c3a'
  #   message = client.messages.create from: 'sender_number', to: 'reciever_number', body: 'Hello there, your OTP is "#{@user.otp_code}"'
  #   render plain: message.status
  # end


  def otp_conf
    if session[:code] == params[:otp]
      if User.find(session[:user]).authenticate_otp(params[:otp], drift:60) == true
        @user = User.find(session[:user])
        @user.confirmed_at = Time.now
        @user.confirmation_token = params[:otp]
        @user.save
      end
    end
  end
end
