# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
NewsItem.create!(author: 'smoke', title: 'Warrnambool win', synopsis: 'Melbourne Ballers win Warrnambool 2013', created_at: DateTime.parse("Feb 1, 2013"))
NewsItem.create!(author: 'smoke', title: 'Ballarat win', synopsis: 'MUBC men win Ballarat 2012', created_at: DateTime.parse("March 30, 2012"))
NewsItem.create!(author: 'smoke', title: 'Albury win', synopsis: 'MUBC men win albury 2011', created_at: DateTime.parse("December 1, 2011"))
NewsItem.create!(author: 'smoke', title: 'Corporate Games win', synopsis: "Andy's Army win Corporate Games 2011", created_at: DateTime.parse("October 1, 2011"))

Page.create!(title: Page::JOIN_THE_CLUB, synopsis: "Join Melbourne University Basketball Club", content: "TODO: administrate!")
Page.create!(title: Page::DOCUMENTS_AND_FORMS, synopsis: "Club Specific Documents and Forms (eg. the membership form)", content: "TODO: administrate!")
Page.create!(title: Page::LINKS, synopsis: "Web links relevant to club members", content: "TODO: administrate!")
