class NewsItem < ActiveRecord::Base
  attr_accessible :article, :author, :synopsis, :title
  validates_presence_of :title, :synopsis, :author
end
