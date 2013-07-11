class Author < ActiveRecord::Base
  has_many :posts
  has_many :comments, :through => :posts
  attr_accessible :name, :username

  validates :name, :username, :presence => true 
  validates_uniqueness_of :username, :case_sensitive => false
end
