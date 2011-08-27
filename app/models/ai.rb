class Ai < ActiveRecord::Base
  attr_accessible :name, :source, :user_id, :public

  belongs_to :user

  validates_presence_of :name, :source, :user
  validates_uniqueness_of :name
  validates_format_of :file_name, :with => /\.rb$/, :on => :create, :message => "must be a ruby file"

  before_validation :set_name_from_file_name

  scope :public, where(:public => true)

  def set_name_from_file_name
    self.name = File.basename(self.file_name, ".*").camelize
  end
end
