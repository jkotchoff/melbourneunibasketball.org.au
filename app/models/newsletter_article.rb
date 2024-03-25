class NewsletterArticle < NewsItem
  has_one_attached :newsletter

  include Rails.application.routes.url_helpers

  attr_accessor :volume_number, :edition_number

  after_initialize do
    self.title ||= "Tin Alley Grapevine #{self.created_at&.year || Date.today.year} - Volume #{volume_number} Edition #{edition_number}"
  end
end
