class DomesticController < ApplicationController
  before_action :load_sidebar

  def index
    render_page(Page::DOMESTIC)
  end

  def faq
    render_page(Page::DOMESTIC_FAQ)
  end

  def fixtures
    render_page(Page::DOMESTIC_FIXTURES)
  end

  def uniforms
    render_page(Page::DOMESTIC_UNIFORMS)
  end

  protected
    def load_sidebar
      @left_sidebar = "sidebars/domestic"
    end
end
