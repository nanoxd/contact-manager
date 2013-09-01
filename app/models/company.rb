class Company < ActiveRecord::Base
  attr_accessible :name, :user_id
  validates :name, presence: true
  include Contact

  def to_s
    "#{name}"
  end
end
