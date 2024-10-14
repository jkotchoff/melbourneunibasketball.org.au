teams_of_decades = Page.find_or_initialize_by(title: Page::AWARDS_TEAMS_OF_THE_DECADES)
teams_of_decades.update!(synopsis: "Teams of the Decades", content: "TODO: administrate!") unless teams_of_decades.persisted?
