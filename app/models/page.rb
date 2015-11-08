class Page < ActiveRecord::Base
  attr_accessible :title, :synopsis, :content, :created_at, :author, :pdf, :remove_pdf, :sticky, :dribbling_balls_link

  validates_presence_of :title

  mount_uploader :pdf, PdfUploader
  
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
  
  EVENT_CALENDAR                  = "Event Calendar"

  ABOUT_THE_CLUB                  = "About The Club"
  BIG_V                           = "Big V Program"
  SPONSORS                        = "Sponsors"
  CONSTITUTION                    = "Constitution"
  
  AWARDS_TITLES                   = "Competition Titles"
  AWARDS_REPRESENTATIVE_MVPS      = "Representative MVP's"
  AWARDS_TEAM_MVPS                = "Team MVP's"
  AWARDS_MOST_IMPROVED_PLAYERS    = "Most Improved Players"
  AWARDS_BEST_FIRST_YEAR_PLAYERS  = "Best First Year Players"
  AWARDS_COACHES_AWARDS           = "Coaches Awards"

  AWARDS_BIGV_LEAGUE              = "Big V League Awards"
  AWARDS_BIGV_SEASON              = "Big V Season Results"
  
  UNIGAMES_TEAMS                  = "University Games Teams"
  AWARDS_BLUES                    = "University Games Blues"
  AWARDS_GREEN_AND_GOLD           = "University Games Green and Gold"
  
  AWARDS_COMMITTEE                = "Executive Committee Members"
  AWARDS_SOCIAL                   = "Social Performers of the year"
  AWARDS_DISTINGUISHED_SERVICE    = "Distinguished Service Award Winners"
  AWARDS_LIFERS                   = "Life Members"

  CONTACT_JOIN_THE_CLUB           = "Join the Club"
  CONTACT_DOCUMENTS_AND_FORMS     = "Documents and Forms"
  CONTACT_UNIFORMS                = "Uniforms"

  PANEL_HOME_SIDEBAR              = "Home Side Panel"

  def has_pdf?
    pdf? or dribbling_balls_link.present?
  end
  
  def pdf_link
    pdf? ? pdf_url : dribbling_balls_link
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
