class EmailAddress < ActiveRecord::Base
  attr_accessible :address, :person_id
  validates :address, presence: true
  belongs_to :person
end
