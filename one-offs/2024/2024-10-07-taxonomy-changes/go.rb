Page.find_by(title: "University Games Teams")&.destroy
Page.find_by(title: "Social Performers of the year")&.destroy
defensive_player_page = Page.find_or_initialize_by(title: Page::AWARDS_DEFENSIVE_PLAYERS)
defensive_player_page.update!(synopsis: "Best Defensive Player Award", content: "TODO: administrate!") unless defensive_player_page.persisted?
player_excellence_page = Page.find_or_initialize_by(title: Page::AWARDS_PLAYER_EXCELLENCE)
player_excellence_page.update!(synopsis: "Scott Cuffe Award for Player Excellence", content: "TODO: administrate!") unless player_excellence_page.persisted?
