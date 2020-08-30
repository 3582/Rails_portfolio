module Api
  module V1
    class Api::V1::ImagesController < ApplicationController
      def create
        image = Image.new(image_params)
        if image.save
          render json: { status: "image_saved"}
        else
          render json: { status: "image_failed"}
        end
      end

      def fetch_latest_image
        image = Image.last.image

        url = url_for(image)
        render json: {url:url}
      end

      private
      def image_params
        params.permit(:image)
      end
    end
  end
end
