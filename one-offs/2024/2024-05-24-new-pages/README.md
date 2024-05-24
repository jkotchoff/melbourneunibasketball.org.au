```ruby
Page.create!(title: "Domestic Program", synopsis: "Melbourne Uni is one of the biggest domestic clubs for adult members", content: "TODO: administrate!")
Page.create!(title: "Walkover Policy", synopsis: "What to do when a walkover occurs", content: "TODO: administrate!")
Page.create!(title: "Insurance Claims Policy", synopsis: "What to do when someone is hurt playing for Melbourne Uni", content: "TODO: administrate!")
Page.create!(title: "Contact Us", synopsis: "How to get in touch with MUBC", content: "TODO: administrate!")
Page.create!(title: "Domestic FAQs", synopsis: "Common questions about playing domestically for Melbourne Uni", content: "TODO: administrate!")
Page.create!(title: "Domestic Fixtures", synopsis: "Season fixtures for MUBC domestic teams", content: "TODO: administrate!")
Page.find_by(title: "Documents and Forms").destroy
Page.create!(title: "Code of Conduct", synopsis: "Code of Conduct at MUBC", content: "TODO: administrate!")
Page.create!(title: "Big V Fixtures", synopsis: "Fixtures for our Big V teams", content: "TODO: administrate!")
Page.create!(title: "Big V Teams", synopsis: "Players for our Big V teams", content: "TODO: administrate!")
Page.create!(title: "Big V Results", synopsis: "Results for our Big V teams", content: "TODO: administrate!")
```