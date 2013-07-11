class Comment < ActiveRecord::Base
  belongs_to :author
  belongs_to :post
  attr_accessible :content, :author_id, :post_id

  validates :content, :author_id, :post_id, :presence => true 

  def paragraphize
    content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n").html_safe
  end
end
