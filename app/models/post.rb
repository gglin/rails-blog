class Post < ActiveRecord::Base
  belongs_to :author
  has_many   :comments
  attr_accessible :content, :title, :author_id

  validates :content, :title, :author_id, :presence => true 

  def paragraphize
    content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n").html_safe
  end
end
