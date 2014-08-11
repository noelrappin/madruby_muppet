class HomeController < ApplicationController

  def index
    @events = Event.order("performance_time ASC").take(4)
  end
end
