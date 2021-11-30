class SetBidStateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    p "Bonjour les gens !"
    Bid.active.finished.update_all(state: "closed")
    Bid.waiting.starting.update_all(state: "actived")
    
    p "Oh yeah"
  end
end
