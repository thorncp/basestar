class Ai < ActiveRecord::Base
  attr_accessible :name, :source, :user_id, :public

  belongs_to :user

  validates_presence_of :name, :source, :user
  validates_uniqueness_of :name
  validates_format_of :file_name, :with => /\.rb$/, :on => :create, :message => "must be a ruby file"
end
