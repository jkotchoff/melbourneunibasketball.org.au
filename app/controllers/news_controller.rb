class NewsController < ApplicationController
  # GET /
  def index
    @news_items = NewsItem.order('created_at DESC').first(8)
    @right_sidebar = Page.find_by_title(Page::PANEL_HOME_SIDEBAR)

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @news_items }
    end
  end
  
  def archived
    @archived_year = (params[:archived_year] || Date.today.year).to_i
    @archived_years = NewsItem.archived_years
    @news_items = NewsItem.for_year(@archived_year)
    @left_sidebar = "sidebars/news"
  end
  
  def dribbling_balls
    @newsletters = NewsItem.dribbling_balls
  end

  def news_item
    @page = Page.find(params[:article])
    render "pages/show"
  end

  def event_calendar
    render_page(Page::EVENT_CALENDAR)
  end
end
