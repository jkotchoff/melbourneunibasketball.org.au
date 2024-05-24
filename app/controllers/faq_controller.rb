class FaqController < ApplicationController
  def index
    render_page(Page::FAQ)
  end
end
