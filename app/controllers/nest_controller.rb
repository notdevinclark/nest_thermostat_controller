class NestController < ApplicationController
  def index
    render json: { hello: :world }.to_json
  end

  def create

  end
end
