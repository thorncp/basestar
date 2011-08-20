class Ai < ActiveRecord::Base
  attr_accessible :name, :source, :user_id

  belongs_to :user

  validates_presence_of :name, :source, :user
  validates_uniqueness_of :name
end
