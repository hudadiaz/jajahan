class HomeController < ApplicationController
  def index
    if data_params.has_key?(:type)
      render json: JajahanData.fetch_data(data_params)
    else
      render json: JajahanData.options
    end
  end

  private

  def data_params
    params.permit(:type, :area)
  end
end
