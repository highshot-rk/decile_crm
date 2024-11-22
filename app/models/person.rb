class Person < ApplicationRecord
  belongs_to :company, optional: true

  validates :first_name, :last_name, :email, presence: true
  validates :probability, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false, message: 'has already been taken' }, 
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }

  enumerize :stage,
            in: {
              lead: 0,
              contacted: 1,
              diligence: 2,
              closed: 3,
              rejected: 4
            }, scope: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
