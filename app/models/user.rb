class User < ApplicationRecord
  has_many :bids_offers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :store
  has_many :carts
  has_many :orders
  has_many :chats
  has_many :searches
  has_many :favorites
  has_many :chats
  has_many :comments
  has_one :account
  has_one_attached :avatar
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, 
          :omniauthable, omniauth_providers: [:google_oauth2, :facebook ]

    scope :all_expect, -> (user){ where.not(id: user.id)}
    # Ex:- scope :active, -> {where(:active => true)}

    
  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      #raise auth[:email].inspect
      user.email = auth[:email]
      user.password = Devise.friendly_token[0,20]
      #user.last_name = auth[:name]   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
      user.save!
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
