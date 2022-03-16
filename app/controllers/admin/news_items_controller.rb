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
    @page = NewsItem.new(news_item_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to [:admin, @page], notice: 'News Item was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @page = NewsItem.friendly.find(params[:id])

    respond_to do |format|
      if @page.update(news_item_params)
        format.html { redirect_to admin_page_path(@page), notice: 'News Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_image
    # https://medium.com/@kristina.kabosiene/manual-upload-rails-6-active-storage-tinymce-5-and-aws-s3-2f139c0b5df4
    # https://objectivefs.com/howto/how-to-restrict-s3-bucket-policy-to-only-one-aws-s3-bucket
    blob = ActiveStorage::Blob.create_after_upload!(
      io: params[:file],
      filename: params[:file].original_filename,
      content_type: params[:file].content_type
    )
    
    render json: {location: url_for(blob)}, content_type:  "text / html"
  end

private
  def news_item_params
    params.require(:news_item).permit(
      :title, :author, :synopsis, :content, :created_at
    )
  end

end
