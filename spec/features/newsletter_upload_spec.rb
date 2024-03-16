require 'spec_helper'

feature "NewsItems" do
  scenario "POST /admin/newsletters" do
    visit admin_newsletters_path
    find("#create-newsletter").click
    fill_in "Volume number", :with => "29"
    fill_in "Edition number", :with => "10"
    fill_in "Author", :with => "The editor"
    fill_in "Synopsis", :with => "Albury tournament, coach Walker & Rapley memorial, (300kb, 6 pages)"
    find('form input[type="file"]').set(Rails.root.join('spec', 'fixtures', 'newsletter.pdf'))
    click_button "Create Newsletter"
    expect(NewsItem.dribbling_balls.count).to eq 1
    page.should have_content("Newsletter 'Tin Alley Grapevine 2024 - Volume 29 Edition 10' was successfully created")
    page.should have_content("Walker & Rapley")
end
end
