class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def render_page(title)
    @page = Page.find_by_title(title)
    render "pages/show"
  end
end
