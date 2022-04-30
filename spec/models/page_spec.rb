require 'spec_helper'

describe Page do
  describe "content image tags" do
    it "strips the ../ prefixes on activestorage s3 image redirects urls" do
      content = "This season's team:<br/><img src=\"../../rails/active_storage/blobs/redirect/eyJfc\"/>"
      content += "Next season's team:<br/><IMG src='../../rails/active_storage/blobs/redirect/xyz'></IMG>"
      page = Page.make!(content: content)
      expect(page.content).to include("<img src=\"/rails/active_storage/blobs/redirect/eyJfc\">")
      expect(page.content).to include("<img src=\"/rails/active_storage/blobs/redirect/xyz\">")
    end
  end

  describe "#default_image_url" do
    it "returns the url of the first image in the html content" do
      content = "This season's team:<br/><img src=\"IMAGE_PATH_1\">"
      content += "Next season's team:<br/><img src=\"IMAGE_PATH_2\">"
      page = Page.make(content: content)
      expect(page.summary_image).to eq("IMAGE_PATH_1")
    end
  end
end  
