class Company < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  include Contact

  def to_s
    "#{name}"
  end
end
