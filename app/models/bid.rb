class Bid < ApplicationRecord
  belongs_to :product
  has_many :offers
  
  has_one :active_bid, -> { where(state: 'actived') } 

  # validates :initial_price, :start_date, :end_date,presence: true, numericality: { greater_than_or_equal_to: 5000 }
  # validate :right_start_date, :right_end_date

  scope :starting, -> { where("start_date <= ?", DateTime.current) }
  
  scope :waiting, -> { where(state: 'waiting') }
  scope :active, -> { where(state: 'actived') }
  
  scope :finished, -> { where("end_date <= ?", DateTime.current) }
  
  def right_start_date
    if start_date.present? == true && start_date < DateTime.current || (start_date.min != 0 && start_date.min != 30)
      errors.add(:start_date, "***Revoyez svp la date ou l'heure de début !***")
      # errors.add(:start_date, "***L'heure doit être supérieure à l'heure actuelle !***")
    elsif start_date.present? == false
      errors.add(:start_date, "***Entrez une date de début***")
    end
  end

  def right_end_date
    if end_date.present? == true && end_date <= start_date || (end_date.min != 0 && end_date.min != 30)
      errors.add(:end_date, "***Revoyez svp la date ou l'heure de début !***")
    elsif end_date.present? == false
      errors.add(:end_date, "***Entrez la date de fin***")
    end
  end

end