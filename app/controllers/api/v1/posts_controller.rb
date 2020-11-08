module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, :only => %i[show update destroy]
      before_action :authenticate_user!, :only => %i[create update destroy]
      def index
        render :json => Post.all
      end

      def recent
        @post = Post.limit(params[:recent])

        render :json => @post.order("created_at DESC"), :status => 200
      end
      def show
        render :json => @post, :status => 200
      end

      def create
        @post = Post.new(post_params)
        tag_list =  params[:tag_name].split(",")
        if @post.save
          @post.save_posts(tag_list)
          render :json => @post, :status => 200
        else
          render :json => @post.errors, :status => 500
        end
      end

      def update
        tag_list =  params[:tag_name].split(",")
        if @post.update!(post_params)
          @post.save_posts(tag_list)
          render :json => @post
        else
          render :json => @post.errors, :status => :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
        render :json => "destroy a post.\n"
      end

      private

      def post_params
        params.permit(:title, :text).merge(:user_id => current_user.id)
      end

      def set_post
        @post = Post.find(params[:id])
      end
    end
  end
end
