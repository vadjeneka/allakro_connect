class BidMailer < ApplicationMailer
  default from: 'noreply@jokou.africa'
  # @Offer.includes(:user)
  # @Offer.each do|offer|
  #  offer.user.email

  def new_offer_email
    @bid = params[:bid]
    offers = @bid.offers
    bid_owner = @bid.product.store.user
    offers.each do |offer|
      mail(to: offer.user.email, subject: "Nouvelle offre sur un produit")
    end
    # Send mail to user bid owner
    # mail(to: bid_owner.email, subject: "Nouvelle offre sur un produit")
  end

  def new_offer_owner_email
    @bid = params[:bid]
    bid_owner = @bid.product.store.user
    mail(to: bid_owner.email, subject: "Nouvelle offre sur un produit")
  end

  def closed_bid_email
    @bid = params[:bid]
    offers = @bid.offers
    bid_owner = @bid.product.store.user
    offers.each do |offer|
      mail(to: offer.user.email, subject: "Fin de l'enchère")
    end
  end

  def closed_bid_owner_email
    @bid = params[:bid]
    bid_owner = @bid.product.store.user
    mail(to: bid_owner.email, subject: "Fin de l'enchère")
  end
end
