class EmailAddress < ActiveRecord::Base
  attr_accessible :address, :person_id
  validates :address, :person_id, presence: true
  belongs_to :person
end
