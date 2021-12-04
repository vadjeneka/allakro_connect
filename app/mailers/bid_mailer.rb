class BidMailer < ApplicationMailer
  default from: 'noreply@jokou.africa'
  # @Offer.includes(:user)
  # @Offer.each do|offer|
  #  offer.user.email

  def new_offer_email
    @offer = params[:offer]
    
    mail(to: @offer.user.email, subject: "You got a new offer!")
  end

  def closed_bid_email
    @offer = params[:offer]
    mail(to: @offer.user.email, subject: "Your offer has been closed!")
  end
end
