class NestController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def create
    render json: EchoRequest.new(params['nest']).response
  end
end
