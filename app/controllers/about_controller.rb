class AboutController < ApplicationController
  # GET /
  def index
    # @contact_pages = Page.where("title in (?)", @contact_links.keys)
  end
  
  def about_the_club
    render_page(Page::ABOUT_THE_CLUB)
  end

  def competition_titles
    render_page(Page::AWARDS_TITLES)
  end

  def representative_mvps
    render_page(Page::AWARDS_REPRESENTATIVE_MVPS)
  end
  
  def team_mvps
    render_page(Page::AWARDS_TEAM_MVPS)
  end
  
  def most_improved_players
    render_page(Page::AWARDS_MOST_IMPROVED_PLAYERS)
  end
  
  def best_first_year_players
    render_page(Page::AWARDS_BEST_FIRST_YEAR_PLAYERS)
  end
  
  def coaches_awards
    render_page(Page::AWARDS_COACHES_AWARDS)
  end
  
  def bigv_league_awards
    render_page(Page::AWARDS_BIGV_LEAGUE)
  end
  
  def bigv_seasons
    render_page(Page::AWARDS_BIGV_SEASON)
  end
  
  def blues_awards
    render_page(Page::AWARDS_BLUES)
  end
  
  def green_and_gold_winners
    render_page(Page::AWARDS_GREEN_AND_GOLD)
  end
  
  def committee
    render_page(Page::AWARDS_COMMITTEE)
  end
  
  def social_awards
    render_page(Page::AWARDS_SOCIAL)
  end
  
  def distinguished_service_awards
    render_page(Page::AWARDS_DISTINGUISHED_SERVICE)
  end
  
  def life_members
    render_page(Page::AWARDS_LIFERS)
  end
end
