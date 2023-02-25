class NewsItem < Page
  validates_presence_of :author

  scope :for_year, lambda {|year| where("created_at >= ? and created_at <= ?", "#{year}0101", "#{year}1231").order('created_at DESC')}
  scope :dribbling_balls, -> { where("dribbling_balls_link is not null") }
  scope :sticky, -> { where("sticky = true") }

  include ActionView::Helpers::TextHelper

  def self.archived_years
    # Postgres-specific, refer: http://stackoverflow.com/questions/6942986/how-to-find-distinct-years-from-a-table-with-multiple-years-in-rails
    # Stopped working feb 25th, 2023? Maybe because of a postgres upgrade?
    #self.select("distinct(extract(year from created_at))").collect(&:date_part).collect(&:to_i).sort.reverse
    self.all.collect(&:created_at).collect(&:year).uniq.sort.reverse
  end

  def has_page?
    content_images.length > 1 or content.try(:length).to_i > 255
  end

  def summary
    textual_content = (content || "").split("<table").first
    textual_content = ActionView::Base.full_sanitizer.sanitize(textual_content)
    truncate(textual_content, length: 255) unless textual_content.blank?
  end
end
