module ApplicationHelper
  def content_html_with_linked_images(news_item)
    return "" if news_item.content.blank?
    html = Nokogiri::HTML::DocumentFragment.parse(news_item.content)
    news_item.content_images.each do |img|
      # Wrap each image with a link to the original high-def image
      link_url     = img.image_url(:standard).gsub("http://", "https://")
      fullsize_url = img.image_url.gsub("http://", "https://")
      instances = html.css("img[src='#{link_url}']")
      unless instances.blank?
        instances.wrap("<a href=\"#{fullsize_url}\"></a>")
      end
    end
    html.to_s.html_safe
  end
end
