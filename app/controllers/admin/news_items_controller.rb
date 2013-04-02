class Admin::NewsItemsController < Admin::PagesController
  def index
    @archived_year = (params[:archived_year] || Date.today.year).to_i
    @archived_years = NewsItem.archived_years
    @news_items = NewsItem.for_year(@archived_year)
    @sticky_news_items = NewsItem.sticky
  end

  def new
    @page = NewsItem.new(author: "the black angels")
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

  def update
    @page = NewsItem.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:news_item])
        format.html { redirect_to admin_page_path(@page), notice: 'News Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end


end
