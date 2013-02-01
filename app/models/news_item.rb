class NewsItem < ActiveRecord::Base
  attr_accessible :article, :author, :synopsis, :title, :created_at
  validates_presence_of :title, :synopsis, :author
  
  scope :for_year, lambda {|year| where("created_at >= ? and created_at <= ?", "#{year}0101", "#{year}1231")}
  
  def self.archived_years
    # Postgres-specific, refer: http://stackoverflow.com/questions/6942986/how-to-find-distinct-years-from-a-table-with-multiple-years-in-rails
    self.select("distinct(extract(year from created_at))").collect(&:date_part).collect(&:to_i).sort.reverse
  end
end
