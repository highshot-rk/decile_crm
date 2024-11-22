class Company < ApplicationRecord
  has_many :people, dependent: :destroy

  validates :name, presence: true
end
