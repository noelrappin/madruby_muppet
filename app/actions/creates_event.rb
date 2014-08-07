class CreatesEvent

  attr_accessor :params, :event, :success

  def initialize(params)
    @params = params
    @success = false
  end

  def run
    @event = Event.new(params)
    @event.capacity.times do
      @event.tickets.build(status: "unsold", access_level: "general")
    end
    (@event.vip_capacity || 0).times do
      @event.tickets.build(status: "unsold", access_level: "vip")
    end
  end

  def save
    @success = @event.save
  end

  def create
    run
    save
  end

end
