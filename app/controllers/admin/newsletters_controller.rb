class Admin::NewslettersController < Admin::BaseController
  def index
    @newsletters = NewsletterArticle.all
  end

  def new
    @newsletter = NewsletterArticle.new(author: "The Editor")
  end

  def create
    @newsletter = NewsletterArticle.new(news_item_params)
    respond_to do |format|
      if @newsletter.save
        @newsletter.update!(dribbling_balls_link: rails_blob_url(@newsletter.newsletter, only_path: !Rails.env.production?))
        format.html { redirect_to [:admin, :newsletters], notice: "Newsletter '#{@newsletter.title}' was successfully created." }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @page = NewsletterArticle.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, :newsletters] }
      format.json { head :no_content }
    end
  end

private
  def news_item_params
    params.require(:newsletter_article).permit(
      :volume_number, :edition_number, :author, :synopsis, :created_at, :newsletter
    )
  end

end
