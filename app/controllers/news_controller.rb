class NewsController < ApplicationController
  # GET /
  def index
    @news_items = NewsItem.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @news_items }
    end
  end
  
  def archived
    @archived_years = NewsItem.archived_years
    if @archived_year = params[:archived_year]
      @news_items = NewsItem.for_year(@archived_year)
    end
  end
end
