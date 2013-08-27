class Company < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  include Contact
end
