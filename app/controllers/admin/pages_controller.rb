class Admin::PagesController < Admin::BaseController
  # GET /admin/pages
  # GET /admin/pages.json
  def index
    @pages = Page.where(type: nil).order(:title)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /admin/pages/1
  # GET /admin/pages/1.json
  def show
    @page = Page.friendly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end
=begin
  # All the static pages are seeded in db/seeds.rb
  # and all the news item pages (ie. dynamic content)
  # are created from the NewsItemsController

  # GET /admin/pages/new
  # GET /admin/pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end
=end
  # GET /admin/pages/1/edit
  def edit
    @page = Page.friendly.find(params[:id])
  end

  # POST /admin/pages
  # POST /admin/pages.json
  def create
    @page = Page.new

    respond_to do |format|
      if @page.save
        format.html { redirect_to [:admin, @page], notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/pages/1
  # PUT /admin/pages/1.json
  def update
    @page = Page.friendly.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(page_params)
        format.html { redirect_to [:admin, @page], notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.json
  def destroy
    @page = Page.friendly.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to admin_pages_url }
      format.json { head :no_content }
    end
  end

private
  def page_params
    params.require(:page).permit(
      :title,
      :synopsis,
      :content,
      :created_at,
      :author,
      :pdf,
      :remove_pdf,
      :sticky,
      :dribbling_balls_link,
      :pdf,
      {
        content_images: []
      }
    )
  end

end
