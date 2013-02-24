class Page < ActiveRecord::Base
  attr_accessible :title, :synopsis, :content, :created_at, :author, :image, :image_cache, :remove_image

  validates_presence_of :title

  mount_uploader :image, ImageUploader
  process_in_background :image
  
  has_many :content_images, dependent: :destroy
  
  after_update :prune_images
  
  # If you add something here, be sure to also modify:
  # db/seeds.rb
  # config/routes.rb
  # app/controllers/application_controller
  
  EVENT_CALENDAR                  = "Event Calendar"

  ABOUT_THE_CLUB                  = "About The Club"
  BIG_V                           = "Big V Program"
  SPONSORS                        = "Sponsors"
  
  AWARDS_TITLES                   = "Competition Titles"
  AWARDS_REPRESENTATIVE_MVPS      = "Representative MVP's"
  AWARDS_TEAM_MVPS                = "Team MVP's"
  AWARDS_MOST_IMPROVED_PLAYERS    = "Most Improved Players"
  AWARDS_BEST_FIRST_YEAR_PLAYERS  = "Best First Year Players"
  AWARDS_COACHES_AWARDS           = "Coaches Awards"

  AWARDS_BIGV_LEAGUE              = "Big V League Awards"
  AWARDS_BIGV_SEASON              = "Big V Season Results"
  
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

  def prune_images
    content_images.each do |image|
      image.destroy unless image.image? and content.index(image.image_url(:standard)) 
    end
  end

end
