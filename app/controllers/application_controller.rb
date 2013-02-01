class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_navigation
  
  def load_navigation
    @contact_links = ActiveSupport::OrderedHash.new.tap do |p|
      p[Page::JOIN_THE_CLUB] = join_the_club_path
      p[Page::DOCUMENTS_AND_FORMS] = documents_and_forms_path
      p[Page::LINKS] = links_path
    end
  end
  
  def render_page(title)
    @page = Page.find_by_title(title)
    render "pages/show"
  end
end
