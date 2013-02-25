class Admin::TinymceAssetsController < Admin::BaseController
  def create
    image_url = nil
    if params[:hint].blank?
      image_url = '/assets/not_saved_upload_error.png'
    else
      @page = Page.find(params[:hint])
      image_record = @page.content_images.new
      image_record.image = params[:file]
      image_record.save
      image_url = image_record.image_url(:standard)
    end
    
    
    render json: {
      image: {
        url: image_url
      }
    }, content_type: "text/html"
  end
end
