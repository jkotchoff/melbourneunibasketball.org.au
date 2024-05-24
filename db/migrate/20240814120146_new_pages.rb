class NewPages < ActiveRecord::Migration[6.1]
  NEW_PAGES = {
    Page::CONTACT_US => "Get in touch with Melbourne Uni Basketball Club",
    Page::DOMESTIC => "Adult basketball teams in Melbourne in Men's and Women's divisions for all levels of skill",
    Page::BIG_V_FIXTURES => "The Melbourne University Big V Fixtures and home games",
    Page::BIG_V_TEAMS => "The players in our Big V program",
    Page::FAQ => "Frequently Asked Questions",
    Page::COMPETITION_RESULTS_BIG_V => "Big V Competition Results",
    Page::COMPETITION_RESULTS_STUDENT_BASKETBALL => "Student Basketball Competition Results",
  }

  def up
    NEW_PAGES.each_pair do |page_title, synopsis|
      Page.create!(title: page_title, synopsis: synopsis, content: "Coming Soon..")
    end
    Page.find_by(title: "Big V Program").update!(title: Page::BIG_V)
    Page.find_by(title: "Competition Titles").update!(title: Page::COMPETITION_TITLES_DOMESTIC_AND_TOURNAMENTS)
  end

  def down
    NEW_PAGES.keys.each do |page_title|
      Page.find_by(title: page_title).destroy
    end
    Page.find_by(title: Page::BIG_V).update!(title: "Big V Program")
    Page.find_by(title: Page::COMPETITION_TITLES_DOMESTIC_AND_TOURNAMENTS).update!(title: "Competition Titles")
  end
end
