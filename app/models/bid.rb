class Bid < ApplicationRecord
  belongs_to :product
  has_many :offers , :dependent => :destroy
  has_one :active_bid, -> { where(state: 'actived') } 
  has_one :inventory,:dependent => :destroy

  validates :initial_price, numericality: { greater_than_or_equal_to: 500 }
  validates :start_date, 
            :end_date, presence: true
  #validate :right_start_date, :right_end_date

  scope :starting, -> { where("start_date <= ?", DateTime.current) }
  
  scope :waiting, -> { where(state: 'waiting') }
  scope :active, -> { where(state: 'actived') }
  
  scope :finished, -> { where("end_date <= ?", DateTime.current) }

  scope :closed, -> {where(state:'closed').order(end_date: :desc)}
  scope :not_validated, -> {where(validated: false)}

  def right_start_date
    if self.start_date < DateTime.current || (self.start_date.min != 0 && self.start_date.min != 30)
      errors.add(:start_date, :invalid, message: "***Revoyez svp la date ou l'heure de début !***")
    end
  end

  def right_end_date
    if self.end_date <= start_date || (self.end_date.min != 0 && self.end_date.min != 30)
      errors.add(:end_date, :invalid, message: "***Revoyez svp la date ou l'heure de fin !***")
    end
  end

  # def winner
  #   if self.finished
  #     return self.offers.top
  #   end
  # end

end
