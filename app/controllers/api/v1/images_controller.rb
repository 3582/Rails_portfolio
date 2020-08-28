class Api::V1::ImagesController < ApplicationController
  def create
    image = Image.save(image_params)
    if image.save
      render json: { status: "saved"}
    else
      render json: { status: "failed"}
    end
  end

  def fetch_latest_image
  end

  private
  def image_params
    params.permit(:image)
  end
end
