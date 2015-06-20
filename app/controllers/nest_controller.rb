class NestController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def index
    render json: { hello: :world }.to_json
  end

  def create
    render json: { version: '1.0',
                   response: {
                     outputSpeech: {
                       type: 'PlainText',
                       text: 'Today will provide you a new learning opportunity.  Stick with it and the possibilities will be endless. Can I help you with anything else?'
                     },
                     card: {
                       type: 'Simple',
                       title: 'Horoscope',
                       content: 'Today will provide you a new learning opportunity.  Stick with it and the possibilities will be endless.'
                     },
                     reprompt: {
                       outputSpeech: {
                         type: 'PlainText',
                         text: 'Can I help you with anything else?'
                       }
                     },
                     shouldEndSession: true
                   }
                 }.to_json
  end
end
