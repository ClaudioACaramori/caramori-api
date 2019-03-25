class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all

    respond_with posts
  end

  def show
    post = Post.find_by(id: params[:id])

    respond_with post
  end
end
