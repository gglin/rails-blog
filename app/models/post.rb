class Post < ActiveRecord::Base
  belongs_to :author
  has_many   :comments
  attr_accessible :content, :title, :author_id

  validates :content, :title, :author_id, :presence => true 

  include ActionView::Helpers::UrlHelper
  # include  ActionDispatch::Http::Url

  PREVIEW_LIMIT = 800
  LINE_LIMIT = 12

  SHORTEN_LIMIT = 10000

  def paragraphize
    body = content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n")
    body
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

  def shorten
    if paragraphize.size > SHORTEN_LIMIT
      paragraphize[0..SHORTEN_LIMIT] + ellipsis
    else
      paragraphize
    end
  end

  def ellipsis
    "<strong>#{link_to '...', '/posts/'+self.id.to_s}<strong>"
  end
end
