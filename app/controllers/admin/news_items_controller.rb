class Admin::NewsItemsController < Admin::PagesController
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
