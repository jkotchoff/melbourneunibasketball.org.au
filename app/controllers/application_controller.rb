class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_navigation
  
  def load_navigation

    @about_links = ActiveSupport::OrderedHash.new.tap do |p|
      p[Page::ABOUT_THE_CLUB] = about_the_club_path
      p[Page::AWARDS_TITLES] = competition_titles_path
      p[Page::AWARDS_REPRESENTATIVE_MVPS] = representative_mvps_path
      p[Page::AWARDS_TEAM_MVPS] = team_mvps_path
      p[Page::AWARDS_MOST_IMPROVED_PLAYERS] = most_improved_players_path
      p[Page::AWARDS_BEST_FIRST_YEAR_PLAYERS] = best_first_year_players_path
      p[Page::AWARDS_COACHES_AWARDS] = coaches_awards_path
      p[Page::AWARDS_BIGV_LEAGUE] = bigv_league_awards_path
      p[Page::AWARDS_BIGV_SEASON] = bigv_seasons_path
      p[Page::AWARDS_BLUES] = blues_awards_path
      p[Page::AWARDS_GREEN_AND_GOLD] = green_and_gold_winners_path
      p[Page::AWARDS_COMMITTEE] = committee_path
      p[Page::AWARDS_SOCIAL] = social_awards_path
      p[Page::AWARDS_DISTINGUISHED_SERVICE] = distinguished_service_awards_path
      p[Page::AWARDS_LIFERS] = life_members_path
    end

    @contact_links = ActiveSupport::OrderedHash.new.tap do |p|
      p[Page::CONTACT_JOIN_THE_CLUB] = join_the_club_path
      p[Page::CONTACT_UNIFORMS] = uniforms_path
      p[Page::CONTACT_DOCUMENTS_AND_FORMS] = documents_and_forms_path
      p[Page::CONTACT_LINKS] = links_path
    end
  end
  
  def render_page(title)
    @page = Page.find_by_title(title)
    render "pages/show"
  end
end
