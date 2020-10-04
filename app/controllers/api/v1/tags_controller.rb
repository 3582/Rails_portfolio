module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, :only => %i[show]

      def index
        render :json => Tag.all
      end

      def show
        render :json => @tag
      end

      private

      def set_tag
        @tag = Tag.find(params[:id])
      end
    end
  end
end

