module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, :only => %i[show update destroy]
      before_action :authenticate_user!, :only => %i[create update destroy]
      def index
        render :json => Post.all, :status => 200
      end

      def ranking
        ranking_sql
        if nil != @sql
          @ranking = ActiveRecord::Base.connection.select_all(@sql).to_hash
          render :json => @ranking, :status => 200
        else
          render :json => @sql, :status => 500
        end
      end

      def posts_with_tagname
        @sql = "SELECT posts.id, title, name, total, tag_name, posts.created_at FROM tagmaps INNER JOIN posts ON posts.id = tagmaps.post_id INNER JOIN tags ON tags.id = tagmaps.tag_id INNER JOIN users ON users.id = user_id WHERE tag_name = \"#{params[:tag_name]}\" order by #{params[:order]} DESC LIMIT #{params[:limit]}"

        @ranking = ActiveRecord::Base.connection.select_all(@sql).to_hash
        render :json => @ranking, :status => 200
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
      def ranking_sql
        if nil != (params[:limit] =~ /\A[0-9]+\z/) && "total" == params[:order] || "created_at" == params[:order]
          @sql = "SELECT posts.id, title, name, total, tag_name, posts.created_at FROM tagmaps INNER JOIN posts ON posts.id = tagmaps.post_id INNER JOIN tags ON tags.id = tagmaps.tag_id INNER JOIN users ON users.id = user_id order by #{params[:order]} DESC LIMIT #{params[:limit]}"
        end
      end

      def post_params
        params.permit(:title, :text, :total).merge(:user_id => current_user.id)
      end

      def set_post
        @post = Post.find(params[:id])
      end
    end
  end
end
