class Page < ActiveRecord::Base
  validates_presence_of :title

  mount_uploader :pdf, PdfUploader

  #TODO: introduce `images` via active storage and then deprecate `content_images`
  # We probably also need to create a new s3 bucket or folder to separate things better
  has_many :content_images, dependent: :destroy
  #TODO: process_in_background :content_images

  delegate :year, to: :created_at

  after_update :prune_images

  extend FriendlyId
  friendly_id :title, use: :slugged

  # If you add something here, be sure to also modify:
  # db/seeds.rb
  # config/routes.rb
  # app/controllers/application_controller

  LINK_DOMESTIC_FIXTURES = "https://www.playhq.com/basketball-victoria/org/melbourne-university-basketball-club/57a64b90"

  ABOUT_THE_CLUB                  = "About The Club"
  CONTACT_US                      = "Contact Us"
  EVENT_CALENDAR                  = "Event Calendar"
  SPONSORS                        = "Sponsors"
  SPONSORSHIP                     = "Sponsors"
  CONSTITUTION                    = "Constitution"
  WALKOVER_POLICY                 = "Walkover Policy"
  INSURANCE_CLAIMS_POLICY         = "Insurance Claims Policy"

  DOMESTIC                        = "Play Basketball at MUBC"
  DOMESTIC_UNIFORMS               = "Uniforms"

  BIG_V                           = "About Big V at MUBC"
  BIG_V_FIXTURES                  = "Home Fixture"
  BIG_V_TEAMS                     = "Big V Teams"

  FAQ                             = "FAQ"

  COMPETITION_TITLES_DOMESTIC_AND_TOURNAMENTS = "Competition Titles"
  COMPETITION_RESULTS_BIG_V = "Big V Competition Results"
  COMPETITION_RESULTS_STUDENT_BASKETBALL = "Student Basketball Results"

  AWARDS_REPRESENTATIVE_MVPS      = "Representative MVP's"
  AWARDS_TEAM_MVPS                = "Team MVP's"
  AWARDS_MOST_IMPROVED_PLAYERS    = "Most Improved Players"
  AWARDS_BEST_FIRST_YEAR_PLAYERS  = "Best First Year Players"
  AWARDS_DEFENSIVE_PLAYERS        = "Best Defensive Players"
  AWARDS_PLAYER_EXCELLENCE        = "Player Excellence Award"
  AWARDS_COACHES_AWARDS           = "Coaches Awards"

  AWARDS_BIGV_LEAGUE              = "Big V League Awards"
  AWARDS_BIGV_SEASON              = "Big V Season Results"

  AWARDS_BLUES                    = "University Games Blues"
  AWARDS_GREEN_AND_GOLD           = "University Games Green and Gold"

  AWARDS_COMMITTEE                = "Executive Committee Members"
  AWARDS_DISTINGUISHED_SERVICE    = "Distinguished Service Award Winners"
  AWARDS_LIFERS                   = "Life Members"

  CONTACT_JOIN_THE_CLUB           = "Join the Club"

  PANEL_HOME_SIDEBAR              = "Home Side Panel"


  before_save :clean_s3_urls

  def clean_s3_urls
    html = Nokogiri::HTML.fragment(content)
    html.css('img').each do |img|
      s3_url = img.attr("src")
      if s3_url.starts_with?("../")
        img.set_attribute("src", "/" + s3_url.gsub(/(\.\.\/)/, ""))
      end
    end
    self.content = html.to_s
  end

  def has_pdf?
    pdf? or dribbling_balls_link.present?
  end

  def pdf_link
    pdf? ? pdf_url : dribbling_balls_link
  end

  def default_image_url
    Nokogiri::HTML.fragment(content).css("img").first&.attr("src")
  end

  def summary_image
    content_images.first.try(:image)
  end

  def summary_image?
    !!summary_image
  end

  def prune_images
    content_images.each do |image|
      image.destroy unless image.image? and (content.index(image.image_url(:standard)) or content.index(image.image_url(:thumbnail)) or content.index(image.image_url))
    end
  end

end
