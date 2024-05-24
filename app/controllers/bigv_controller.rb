class BigvController < ApplicationController
  before_action :load_sidebar

  def index
    render_page(Page::BIG_V)
  end

  def fixtures
    render_page(Page::BIG_V_FIXTURES)
  end

  def players
    render_page(Page::BIG_V_TEAMS)
  end

  def results
    render_page(Page::BIG_V_RESULTS)
  end

  protected
    def load_sidebar
      @left_sidebar = "sidebars/bigv"
    end
end
