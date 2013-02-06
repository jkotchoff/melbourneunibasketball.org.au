class ContactController < ApplicationController
  before_filter :load_sidebar

  # GET /
  def index
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

  protected
    def load_sidebar
      @left_sidebar = "sidebars/contact"
    end
end
