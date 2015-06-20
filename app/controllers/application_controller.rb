class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :echo_auth

  private

  def echo_auth
    user_id = params.fetch('session',{}).fetch('user',{}).fetch('userId','')
    echo_not_authorized unless user_id.split('.').last == ECHO_CONFIG[:user_id]
  end

  def echo_not_authorized
    render json: { version: '1.0',
                   response: {
                     outputSpeech: {
                       type: 'PlainText',
                       text: 'You are not authorized to use this application. Goodbye.'
                     },
                     shouldEndSession: true
                   }
                 }.to_json
  end
end
