class Page < ActiveRecord::Base
  attr_accessible :title, :synopsis, :content, :created_at, :author
  
  validates_presence_of :title

  mount_uploader :image, ImageUploader
  
  JOIN_THE_CLUB = "Join the Club"
  DOCUMENTS_AND_FORMS = "Documents and Forms"
  LINKS = "Web Links"
  
=begin  
 TODO: 
  ABOUT_THE_CLUB                = "About The Club"
  AWARDS_TITLES                 = "Competition Titles"
  AWARDS_REPRESENTATIVE_MVPS    = "Representative MVP's"
  AWARDS_TEAM_MVPS              = "Team MVP's"
  AWARDS_MOST_IMPROVED_PLAYERS  = "Most Improved Player"
  BEST_FIRST_YEAR_PLAYERS       = "Best First Year Player"
  COACHES_AWARDS                = "Coaches Awards"
=end  

end
