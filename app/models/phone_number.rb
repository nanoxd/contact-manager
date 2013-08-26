class PhoneNumber < ActiveRecord::Base
  attr_accessible :number, :contact_id, :contact_type
  validates :number, :contact_id, presence: true
  belongs_to :person
  belongs_to :company
  belongs_to :contact, polymorphic: true
end
