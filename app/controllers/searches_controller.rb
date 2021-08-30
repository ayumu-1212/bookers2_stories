class SearchesController < ApplicationController
  def result
    @books = nil
    @users = nil
    if params[:model_name] == "Book"
      case params[:search_style]
      when "perfect" then
        @books = Book.where(title: params[:keyword]).or(Book.where(body: params[:keyword]))
      when "forward" then
        @books = Book.where("title LIKE?", "#{params[:keyword]}%").or(Book.where("body LIKE?", "#{params[:keyword]}%"))
      when "backward" then
        @books = Book.where("title LIKE?", "%#{params[:keyword]}").or(Book.where("body LIKE?", "%#{params[:keyword]}"))
      when "partial" then
        @books = Book.where("title LIKE?", "%#{params[:keyword]}%").or(Book.where("body LIKE?", "%#{params[:keyword]}%"))
      else
      end
    elsif params[:model_name] == "User"
      case params[:search_style]
      when "perfect" then
        @users = User.where(name: params[:keyword]).or(User.where(introduction: params[:keyword]))
      when "forward" then
        @users = User.where("name LIKE?", "#{params[:keyword]}%").or(User.where("introduction LIKE?", "#{params[:keyword]}%"))
      when "backward" then
        @users = User.where("name LIKE?", "%#{params[:keyword]}").or(User.where("introduction LIKE?", "%#{params[:keyword]}"))
      when "partial" then
        @users = User.where("name LIKE?", "%#{params[:keyword]}%").or(User.where("introduction LIKE?", "%#{params[:keyword]}%"))
      else
      end
    end
  end
end
