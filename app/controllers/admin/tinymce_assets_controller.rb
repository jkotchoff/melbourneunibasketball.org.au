class Admin::TinymceAssetsController < Admin::BaseController
  def create
    @page = Page.find(params[:hint])
    
    image_record = @page.content_images.new
    image_record.image = params[:file]
    image_record.save
    
    render json: {
      image: {
        url: image_record.image_url(:standard)
      }
    }, content_type: "text/html"
  end
end
