require 'spec_helper'

feature "NewsItems" do
  scenario "POST /admin/news_items" do
    lambda {
      visit new_admin_news_item_path
      fill_in "Title", :with => "Melbourne Ballers win Warrnambool Tournament"
      fill_in "Author", :with => "smoke"
      fill_in "Content", :with => "Several retired MUBC players banded together to win the 2013 Warrnambool Mens A and A Reserve grades. Smoke, beef, chop, mad, wronghole and air canada stitched up the opposition as a warmup for the return of TML."
      click_button "Create News item"
      page.should have_content("News Item was successfully created.")
      page.should have_content("Melbourne Ballers win Warrnambool Tournament")
    }.should change(NewsItem, :count).by(1)
  end
=begin
  describe "GET /" do
    it "Displays the latest 8 news items" do
      get root_path   # get is a request spec call I think - more for API tests
      response.status.should be(200)
    end
  end
=end
end
