
class StateChangeJob < ApplicationJob
  queue_as :default

  def perform
    # desactivate past bid
    Bid.is_visible.active.finished.update_all(bid_state: 'closed')

    #activate next bid
    Bid.is_visible.waiting.starting.update_all(bid_state: 'active')
  end
end
