class NewsletterArticle < NewsItem
  mount_uploader :newsletter, NewsletterUploader

  attr_accessor :volume_number, :edition_number

  after_initialize do
    self.title ||= "Tin Alley Grapevine #{Date.today.year} - Volume #{volume_number} Edition #{edition_number}"
  end
end
