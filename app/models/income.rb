class Income < ApplicationRecord
  belongs_to :user

  scope :within_period, -> (start_date, end_date) { where(date: start_date..end_date)}
  scope :total_amount, -> { pluck(:amount).sum.to_f }

  validates :title, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :date, presence: true
end
