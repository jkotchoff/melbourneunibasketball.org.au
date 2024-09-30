class AboutController < ApplicationController
  before_action :load_sidebar

  # GET /
  def index
    render_page(Page::ABOUT_THE_CLUB)
  end

  def big_v
    render_page(Page::BIG_V)
  end

  def contact_us
    render_page(Page::CONTACT_US)
  end

  def event_calendar
    render_page(Page::EVENT_CALENDAR)
  end

  def walkover_policy
    render_page(Page::WALKOVER_POLICY)
  end

  def insurance_claims_policy
    render_page(Page::INSURANCE_CLAIMS_POLICY)
  end

  def sponsors
    render_page(Page::SPONSORS)
  end

  def competition_titles_domestic
    render_page(Page::COMPETITION_TITLES_DOMESTIC_AND_TOURNAMENTS)
  end

  def competition_results_big_v
    render_page(Page::COMPETITION_RESULTS_BIG_V)
  end

  def competition_results_students
    render_page(Page::COMPETITION_RESULTS_STUDENT_BASKETBALL)
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

  def unigames_teams
    render_page(Page::UNIGAMES_TEAMS)
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

  def sentry_error
    begin
      1 / 0
    rescue ZeroDivisionError => exception
      Sentry.capture_exception(exception)
    end

    Sentry.capture_message("test message")
  end

  protected
    def load_sidebar
      @left_sidebar = "sidebars/about"
    end
end
