
class StateChangeJob < ApplicationJob
  queue_as :default

  def perform
    # desactivate past bid
    Bid.active.finished.update_all(bid_state: 'closed')

    #activate next bid
    Bid.waiting.starting.update_all(bid_state: 'active')
  end
end
