class Bid < ApplicationRecord
  belongs_to :product
  has_many :bids_offers

  validate :right_start_date, :right_end_date

  validates :initial_price, presence: true, numericality: {greater_than_or_equal_to: 5000}


  def right_start_date
    if start_date.present? && start_date < DateTime.current
      errors.add(:start_date, "***Revoyez svp la date de debut !***")
      errors.add(:start_date, "***L'heure doit être supérieure à l'heure actuelle !***")
    elsif start_date.present? == false
      errors.add(:start_date, "***Entrez une date de début***")
    end
  end

  def right_end_date
    if end_date.present? && end_date <= start_date
      errors.add(:end_date, "***Revoyez la date de fin***")
    elsif end_date.present? == false
      errors.add(:end_date, "***Entrez la date de fin***")
    end
  end

end
