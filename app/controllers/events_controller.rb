class EventsController < ApplicationController
  before_action :set_group

  def index
    @events = @group.events.order(event_date: :desc)
  end

  def show
    @event = @group.events.find(params[:id])
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end

