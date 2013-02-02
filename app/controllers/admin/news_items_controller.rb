class Admin::NewsItemsController < Admin::BaseController
  def new
    @page = NewsItem.new
  end
  
  def create
    @page = NewsItem.new(params[:news_item])

    respond_to do |format|
      if @page.save
        format.html { redirect_to [:admin, @page], notice: 'News Item was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
