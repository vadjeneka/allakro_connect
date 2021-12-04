class SetBidStateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    
    Bid.active.finished.update_all(state: "closed")
    Bid.waiting.starting.update_all(state: "actived")
  end
end
