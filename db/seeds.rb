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

{
  
  Page::ABOUT_THE_CLUB => "Find out why MUBC is a great place to play basketball",
  
  Page::AWARDS_TITLES => "Team Lists for Premierships & Runner Up finishes (VBL, University Games, MMBL, Sunday Night MSAC, Tournaments)",
  Page::AWARDS_REPRESENTATIVE_MVPS => "Male & Female players of the year in our top Mens and Womens teams",
  Page::AWARDS_TEAM_MVPS => "Male & Female players of the year across all teams",
  Page::AWARDS_MOST_IMPROVED_PLAYERS => "Across the board, annual award (male/female)",
  Page::AWARDS_BEST_FIRST_YEAR_PLAYERS => "Club nominated best first year player",
  Page::AWARDS_COACHES_AWARDS => "Encouragement award to a player chosen by the coaches as the most 'coachable' in the club",
  Page::AWARDS_BIGV_LEAGUE => "MVP, All Star 5",
  Page::AWARDS_BIGV_SEASON => "Big V Season Results",
  Page::AWARDS_BLUES => "Awarded by Melbourne University Sport for exemplary Inter-Varsity Contribution",
  Page::AWARDS_GREEN_AND_GOLD => "University Games Green and Gold All-Stars",
  Page::AWARDS_COMMITTEE => "The important (voluntary) folks who give us a place to play",
  Page::AWARDS_SOCIAL => "The stand-out social performers",
  Page::AWARDS_DISTINGUISHED_SERVICE => "An annual award for noteworthy contribution to the club",
  Page::AWARDS_LIFERS => "For exemplary contribution to MUBC",

  Page::CONTACT_JOIN_THE_CLUB => "Join Melbourne University Basketball Club",
  Page::CONTACT_DOCUMENTS_AND_FORMS => "Club Specific Documents and Forms (eg. the membership form)",
  Page::CONTACT_UNIFORMS => "Uniform ordering guide for MUBC playing shorts, singlets and club hoodies",
  Page::CONTACT_LINKS => "Web links relevant to club members"

}.each_pair do |page_title, synopsis|
  Page.create!(title: page_title, synopsis: synopsis, content: "TODO: administrate!")
end

Page.create!(
  title: Page::PANEL_HOME_SIDEBAR, 
  synopsis: "Content for the sidebar on the homepage", 
  content: %Q{
      <p>
        <b>Game Fixtures:</b>
        <ul class="unstyled">
          <li><a href="#">CYMS A Women 1 (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS A Women 2 (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS A Women 3 (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS B Women (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS C Women (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS A Men (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS A Reserve Men (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS B Men (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS C Men (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS D Men (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS E Men (Sundays, MSAC)</a></li>
          <li><a href="#">CYMS G Men (Sundays, MSAC)</a></li>
          <li><a href="#">Spartan League B Women (Tuesdays, MSAC)</a></li>
          <li><a href="#">Spartan League A Men (Tuesdays, MSAC)</a></li>
          <li><a href="#">MMBL Women (Wednesday, Melbourne)</a></li>
          <li><a href="#">VBHBA A Men (Thursdays, MSAC)</a></li>
          <li><a href="#">Big V Div 1 Men (Saturdays, Victoria)</a></li>
          <li><a href="#">Big V Div 2 Women (Saturdays, Victoria)</a></li>
        </ul>
      </p>  
      
      <p>
        <b>Training Times:</b><br/>
        Domestic Women:<br/> 11am-12:30pm, Saturdays<br/><br/>

        Domestic Men (grades A-B):<br/>9am-11am, Saturdays<br/><br/>

        Domestic Men (grades C-G):<br/>11am-12:30pm, Saturdays<br/><br/>
        
        Big V Men:<br/> 8pm-10pm, Mondays &amp; Thursdays<br/><br/>
        Big V Women:<br/> 6:30pm-8:30pm, Mondays &amp; Thursdays<br/><br/>
        
        * All training is held at the Melbourne Uni Sports Center
      </p>  
    
  }
)
