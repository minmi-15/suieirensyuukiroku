class ChartController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
    if session[:offset].nil?
      session[:offset] = 0
    end
    if params[:month] == "next"
      session[:offset] = session[:offset].to_i + 1
    elsif params[:month] == "prev"
      session[:offset] = session[:offset].to_i - 1
    end
    current_date = Date.current.next_month(session[:offset].to_i)
    @current_month = current_date.month
    @posts = current_user.posts
    data = @posts.group(:practice_day).sum(:distance)
    range = (current_date.beginning_of_month..current_date.end_of_month)
    @labels = range.to_a.map(&:to_s)
    @values = range.map { |o| @posts.where(practice_day: o).sum(:distance) }
  end
end
