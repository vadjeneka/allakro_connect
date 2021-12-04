class SetBidStateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "JE COMMENCE..."
    Bid.active.finished.update_all(state: "closed")
    Bid.waiting.starting.update_all(state: "actived")
    puts "C'EST FINI ! MERCI !"
  end
end
