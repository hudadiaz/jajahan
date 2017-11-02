class HomeController < ApplicationController
  def index
    render json: JajahanData.fetch_data(data_params)
  end

  private

  def data_params
    params.permit(:type, :area)
  end
end
