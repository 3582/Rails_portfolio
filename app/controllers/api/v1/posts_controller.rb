module Api
    module V1
      class PostsController < ApplicationController
        def index
          @posts = Post.all
          render json: @posts
        end

        def create
          @post = Post.new(post_params)
          if @post.save
            render json: "create new post.\n", status: 200
          else
            render json: "fail to create.\n", status: 500
          end
        end

        def destroy
          @post = Post.find(params[:id])
          @post.destroy
          render json: "destroy a post.\n"
        end

        private
        def post_params
            params.require(:post).permit(:title, :text)
        end
      end
    end
end
