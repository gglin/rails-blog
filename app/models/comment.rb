class Comment < ActiveRecord::Base
  belongs_to :author
  belongs_to :post
  attr_accessible :content, :author_id, :post_id

  validates :content, :author_id, :post_id, :presence => true 

  include ActionView::Helpers::UrlHelper
  # include  ActionDispatch::Http::Url

  PREVIEW_LIMIT = 340
  LINE_LIMIT = 4

  def paragraphize
    content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n")
  end

  def preview
    if content.scan("\n").size > LINE_LIMIT
      paragraphize[0..PREVIEW_LIMIT].split("\n")[0..LINE_LIMIT].collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n") + ellipsis
    elsif paragraphize.size > PREVIEW_LIMIT
      paragraphize[0..PREVIEW_LIMIT] + ellipsis
    else
      paragraphize
    end
  end

  def ellipsis
    "<strong>#{link_to '...', '/posts/'+self.post_id.to_s}<strong>"
  end
end
