require 'spec_helper'

describe NewsletterArticle do
  describe "#store_dir" do
    it "stores the newsletter in S3 with the correct path" do
      newsletter_article = NewsletterArticle.new(
        volume_number: 33,
        edition_number: 3,
        created_at: Date.new(2023, 04, 24),
      )

      expect(newsletter_article.title).to eq "Tin Alley Grapevine 2023 - Volume 33 Edition 3"
      expect(newsletter_article.newsletter.store_dir).to eq "dribbling_balls"
      expect(newsletter_article.newsletter.filename).to eq "2023_04_24_volume_33_issue_003.pdf"
    end
  end
end
