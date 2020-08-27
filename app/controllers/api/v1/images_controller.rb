class Api::V1::ImagesController < ApplicationController
  def create
  end

  def fetch_latest_image
  end

  private
  def image_params
    params.permit(:image)
  end
end
