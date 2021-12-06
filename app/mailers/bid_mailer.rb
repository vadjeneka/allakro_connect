class BidMailer < ApplicationMailer
  default from: 'noreply@jokou.africa'
  # @Offer.includes(:user)
  # @Offer.each do|offer|
  #  offer.user.email

  def new_offer_email
    @offers = params[:offers]
    @offers.includes(:user).each do |offer|
      mail(to: offer.user.email, subject: "You got a new offer!")
    end
  end

  def closed_bid_email
    @offer = params[:offer]
    mail(to: @offer.user.email, subject: "Your offer has been closed!")
  end
end
