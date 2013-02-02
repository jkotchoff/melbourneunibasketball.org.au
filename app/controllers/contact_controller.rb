class ContactController < ApplicationController
  # GET /
  def index
    @contact_pages = Page.where("title in (?)", @contact_links.keys)
  end
  
  def join_the_club
    render_page(Page::CONTACT_JOIN_THE_CLUB)
  end

  def documents_and_forms
    render_page(Page::CONTACT_DOCUMENTS_AND_FORMS)
  end

  def uniforms
    render_page(Page::CONTACT_UNIFORMS)
  end

  def links
    render_page(Page::CONTACT_LINKS)
  end
end
