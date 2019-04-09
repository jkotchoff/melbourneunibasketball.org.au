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
  Page::EVENT_CALENDAR => "Event Calendar",
  
  Page::ABOUT_THE_CLUB => "Find out why MUBC is a great place to play basketball",
  Page::BIG_V => "Melbourne Uni have both a mens and a womens representantive Big V program for elite players",
  Page::SPONSORS => "Big props to all our fantastic sponsors!",
  Page::CONSTITUTION => "The constitution of Melbourne University Basketball Club",

  
#  Page::AWARDS_TITLES => "Team Lists for Premierships & Runner Up finishes (VBL, University Games, MMBL, Sunday Night MSAC, Tournaments)",
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

  Page::CONTACT_JOIN_THE_CLUB => "MUBC Membership",
  Page::CONTACT_DOCUMENTS_AND_FORMS => "Club Specific Documents and Forms (eg. the membership form)",
  Page::CONTACT_UNIFORMS => "Uniform ordering guide for MUBC playing shorts, singlets and club hoodies"

}.each_pair do |page_title, synopsis|
  Page.create!(title: page_title, synopsis: synopsis, content: "TODO: administrate!")
end

Page.create!(
  title: Page::PANEL_HOME_SIDEBAR, 
  synopsis: "Content for the sidebar on the homepage", 
  content: %Q{
      <p>
        <b>Upcoming Events</b><br/>
        March 1-4: <a href="http://www.twitter.com/MUBCBlackAngels">O-Week booth</a><br/>
        March 8-11: <a href="http://www.facebook.com/melbourneuniversitybasketballclub">Ballarat Tournament</a><br/>
        March 15: <a href="http://www.instagram.com/MelbourneUniBasketball">Big V Double-header</a>
      </p>
      <p style="margin-top:10px; margin-bottom:0px;">
        <b>Season Fixtures</b>
        <ul class="unstyled">
          <li><a href="#"><div class="text-muted">Big V (Saturdays, Victoria)</div>Div 1 Men</a></li>
          <li><a href="#">Div 2 Women</a><br/><br/></li>
          <li><a href="#"><div class="text-muted">CYMS (Sundays, MSAC)</div>A Women 1</a></li>
          <li><a href="#">A Women 2</a></li>
          <li><a href="#">A Women 3</a></li>
          <li><a href="#">B Women</a></li>
          <li><a href="#">C Women</a></li>
          <li><a href="#">A Men</a></li>
          <li><a href="#">A Reserve Men</a></li>
          <li><a href="#">B Men</a></li>
          <li><a href="#">C Men</a></li>
          <li><a href="#">D Men</a></li>
          <li><a href="#">E Men</a></li>
          <li><a href="#">G Men</a><br/><br/></li>
          <li><a href="#"><div class="text-muted">Spartan League (Tuesdays, MSAC)</div>Spartan League B Women</a></li>
          <li><a href="#">Spartan League A Men</a><br/><br/></li>
          <li><a href="#"><div class="text-muted">MMBL (Wednesdays, Melbourne)</div>Div 1 Women</a><br/><br/></li>
          <li><a href="#"><div class="text-muted">VBHBA (Thursdays, MSAC)</div>A Men</a></li>
        </ul>
      </p>
      <p>
        <b>Social Media</b><br/>
        <a href="http://www.facebook.com/melbourneuniversitybasketballclub">MUBC on Facebook</a><br/>
        <a href="http://www.twitter.com/MUBCBlackAngels">MUBC on Twitter</a><br/>
        <a href="http://www.instagram.com/MelbourneUniBasketball">MUBC on Instagram</a>
      </p>
      <p style="margin-top:10px; margin-bottom:0px;">
        <b>Training Times</b><br/>
        <div class="text-muted">Domestic Women</div>Saturdays, 11am-12:30pm<br/><br/>

        <div class="text-muted">Domestic Men (grades A-B)</div>Saturdays, 9am-11am<br/><br/>

        <div class="text-muted">Domestic Men (grades C-G)</div>Saturdays, 11am-12:30pm<br/><br/>
        
        <div class="text-muted">Big V Men</div> Mondays &amp; Thursdays, 8pm-10pm<br/><br/>
        <div class="text-muted">Big V Women</div> Mondays &amp; Thursdays, 6:30pm-8:30pm<br/><br/>
        
        <div class="text-muted">* All training is held at the Melbourne Uni Sports Center</div>
      </p>  
  }
)

Page.find_by_title(Page::CONTACT_JOIN_THE_CLUB).update_attributes(:content => %Q{
  <p>MUBC is a fun place to play basketball, and party!</p>
  <p>As Australia's largest senior domestic basketball club, MUBC offers opportunities to pursue an elite or casual playing career in a non-junior program.</p>
  <p>There are numerous eligibility clauses in regard to Membership.</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <div align="center"><a class="btn btn-danger" style="padding: 14px 36px; font-size: 250%;" href="../../../membership">Join The Club</a>&nbsp;</div>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
})

Page.find_by_title(Page::EVENT_CALENDAR).update_attributes(:content => %Q{
  <table border="1" cellpadding="3">
  <tbody>
  <tr valign="top">
  <td><strong>January 2013</strong></td>
  <td><strong>23rd-25th</strong><br />O-Week</td>
  </tr>
  <tr valign="top">
  <td><strong>Febuary</strong></td>
  <td><strong>23rd-25th</strong><br />Table in North Court and demonstration</td>
  </tr>
  <tr valign="top">
  <td>&nbsp;<strong>March</strong></td>
  <td><strong>8th-11th</strong><br />Ballarat Tournament<br /><br /><strong>11th-13th</strong><br />Big V Tournament&nbsp;</td>
  </tr>
  <tr valign="top">
  <td>&nbsp;<strong>April</strong></td>
  <td><strong>8th</strong><br />Pub Crawl<br /><br /><strong>15th</strong><br />Annual General Meeting<br /><br /><strong>20th</strong><br />Big V Double Header</td>
  </tr>
  </tbody>
  </table>
})


Page.create!(
  title: Page::AWARDS_TITLES, 
  synopsis: "Team Lists for Premierships & Runner Up finishes (VBL, University Games, MMBL, Sunday Night MSAC, Tournaments)", 
  content: %Q{
  <table cellpadding="2" cellspacing="0" class="sortable" id="mubcTitles">
    <caption style="">
    Melbourne University Basketball Titles (<em>Click column headers to sort</em>) 
    </caption>
    <thead style="">
      <tr style=""> 
        <th width="34">Year</th>

        <th width="147">Competition</th>
        <th width="85">Section</th>
        <th width="72">Result</th>
        <th width="95">Opposition</th>
        <th width="178">Coaches</th>
        <th width="358">Players</th>

      </tr>
    </thead>
    <tbody style="vertical-align:top;">
      <tr> 
        <td>2010</td>
        <td>Australian University Games</td>
        <td>Men</td>
        <td>Gold</td>
        <td>Griffith?</td>
        <td>Andrew Walker</td>
        <td>Jimmy Hassett, Peter Rossiter, Daniel Sneddon, Matt Slaven, Callum Repper, Stefan Pomasan, Hunter Santamaria, Tom Bicknell, Jason Conway, Scott Drysdale, Tom Stephens, Tim Clarke</td>
      </tr>
      <tr> 
        <td>2010</td>
        <td>Big V</td>
        <td>Division 1 Men</td>
        <td>Champions</td>
        <td>Geelong</td>
        <td>Andrew Walker, Stuart Black (assistant), Bernie Thompson (assistant)</td>
        <td>Scott Cuffe, Justin Turnley, Jamie Thiessen, Dan Nelson, Nick Masunda, Andrew Webb, Liam Norton, Emel Rowe, Mason Clarke-Jones, Jacob Philpot, Stefan Pomasan, Nathan Luke</td>
      </tr>
      <tr> 
        <td>2009</td>
        <td>Tuesday Nights MSAC A Grade</td>
        <td>Men</td>
        <td>Champions</td>
        <td>Powerhouse</td>
        <td>-</td>
        <td>Paul Mason, Adriano Leti, Jared Fetherston, Justin Turnley, Matthew Hilbrich, James Fidler, Morgan Arundal</td>
      </tr>
      <tr> 
        <td>2009</td>
        <td>Australian University Games</td>
        <td>Women</td>
        <td>Bronze</td>
        <td>Griffith</td>
        <td>Jason Kotchoff</td>
        <td>Melanie Fidler, Charlotte McNamara, Laura Salzone, Bec Wardle, Maree DeWijn, Caitlyn Mackenzie, Nicole Dadswell, Claire Mehrtens, Jess McDonald, Charlotte Ross-Harris, Charlotte Righetti, Steph Righetti</td>
      </tr>
      <tr> 
        <td>2009</td>
        <td>Australian University Games</td>
        <td>Men</td>
        <td>Silver</td>
        <td>QUT</td>
        <td>Stuart Black</td>
        <td>Thomas Bicknell, Jacob Philpot, Tom Stephens, Jason Conway, Paul Kopanidis, Peter Rossiter, Callum Repper, Snedden Claw, Scott Drysdale, Tim Clark, Vukas, Jimmy Hassett</td>
      </tr>
      <tr> 
        <td>2009</td>
        <td>Big V</td>
        <td>Division 2 Men</td>
        <td>Champions</td>
        <td>Horsham</td>
        <td>Andrew Walker, Stuart Black (assistant), Bernie Thompson (assistant)</td>
        <td>Scott Cuffe, Matt Rafton, Tom Bicknell, Justin Turnley, Chris Giosis, Chris Neale, Jamie Thiessen, Dan Nelson, Nick Masunda, Robbie McCoy, Jason Kotchoff, Andrew Webb</td>
      </tr>
      <tr> 
        <td>2009</td>
        <td>Big V</td>
        <td>Division 2 Women</td>
        <td>Runner-Up</td>
        <td>Whittlesea</td>
        <td>James Fidler, Daisy Adams (assistant)</td>
        <td>Rhia Mikkor, Mel Fidler, Claire Pownell, Simone Steele, Kylie Turnley, Shannyn Kelly, Kemperly Dynon, Caitlin Delahunty, Emily Voight, Laura Salsone, </td>
      </tr>
      <tr> 
        <td>2008</td>
        <td>Australian University Games</td>
        <td>Women</td>
        <td>Bronze</td>
        <td>-</td>
        <td>Chris Owen</td>
        <td>Kemperly Dynon, Melanie Fidler, Sophie Hofferberth, Mel Ng, Nicole ?, Jessica Patti, Ellen Heyting, Claire Grady</td>
      </tr>
      <tr> 
        <td>2008</td>
        <td>Big V</td>
        <td>Division 2 Men</td>
        <td>Runner-Up</td>
        <td>La Trobe University</td>
        <td>Andrew Walker, Stuart Black (assistant)</td>
        <td>Tim Medlin, Matthew Rafton, Scott Cuffe, Peter Leppik, Justin Turnley, James Fidler, Jamie Thiessen, Robbie McCoy, Andrew Webb, Peter Rossitter, Daniel Goldsworthy</td>
      </tr>
     <tr>
  <td>2007</td>
  <td>Melbourne Metropolitan Basketball League</td>
  <td>Division 1 Men</td>
  <td>Runner-Up</td>
  <td>Chelsea</td>
  <td>-</td>
  <td>Paul Mason, Justin Turnley, James Rapley, Adriano Leti, Jared Fetherston, Morgan Arundell, Matthew Hillbrich, PJ Estorque, Will Hart</td>
  </tr>
     <tr>
  <td>2006</td>
  <td>Melbourne Metropolitan Basketball League</td>
  <td>Division 1 Men</td>
  <td>Runner-Up</td>
  <td>Blackburn</td>
  <td>Brendan Greene</td>
  <td>Paul Mason, Justin Turnley, James Rapley, Adriano Leti, Jared Fetherston, Morgan Arundell, Matthew Hillbrich, PJ Estorque, Will Hart</td>
  </tr>
      <tr> 
        <td>2005</td>
        <td>Big V (formerly VBL)</td>
        <td>Division 2 Women</td>
        <td><a href="bigv_season_2005.php">Runner-Up</a></td>

        <td>Diamond Valley</td>
        <td>Jim Kondos, Brendan Green (assistant)</td>
        <td>Bree Sherry, Brigid Howell, Claire Pownell, Elizabeth Anderson, Emily 
          Evans, Jayne Bruce, Kirsten Daly, Lauren Donley, Louise Pownell, Meagan 
          Shields, Nat Kondos, Renee Tuck, Sarah Thompson, Simone Steele </td>
      </tr>
      <tr>
        <td>2005</td>
        <td>CYMS</td>

        <td>A Grade Women</td>
        <td>Premier</td>
        <td>Growlers</td>
        <td>Brendan Green</td>
        <td>Melissa 'Joy' Pearson, Lucy Williams, Melanie Fidler, Rhia Mikkor, 
          Danielle Winkelman, Ebonie Delahunty, Caitlyn Delahunty, Eiko Anderson</td>
      </tr>

      <tr> 
        <td>2005</td>
        <td>CYMS</td>
        <td>B Grade Men</td>
        <td>Premier</td>
        <td>Old Xavierians</td>
        <td>Kuhn Ip</td>

        <td>James Hillier, James Love, Brendan, Rana Dhillon, Morgan Arundell, 
          Lachlan Arundell, Cj Ruggles, Tom Leong, Jeremy, Gerry</td>
  </tr><tr>
        <td>2005</td>
        <td>Warrnambool Tournament</td>
        <td>B Grade Men</td>
        <td>Runners Up</td>

        <td>-</td>
        <td>-</td>
        <td>Scott Cuffe, Jason Kotchoff, Matthew Hillbrich, Raef Akehurst, Ben Barnett, Brendan Green, Joel Berry</td>
      </tr>
      <tr> 
        <td>2004</td>
        <td>Victorian Basketball League</td>

        <td>Premier Division - Men</td>
        <td>Champions</td>
        <td>Southern Peninsula</td>
        <td>Dean Vickerman, Glenda De Marinis (assistant)</td>
        <td>Scott Cuffe, James Huttom, James Pescott, Liam Norton, Anthony Nantes, 
          Matthew Rafton, Ben Dewer, Jamie Hagan, Nicholas Masunda, Adrian Sturt, 
          Lucien Boland</td>
      </tr>

      <tr> 
        <td>2004</td>
        <td>Australian University Games</td>
        <td>Women</td>
        <td>Runner-Up</td>
        <td></td>
        <td>Jim Kondos</td>

        <td>Claire Pownell, Jayne Bruce, Simone Steele, Renee Tuck, Kemperley 
          Dynon, Megan Reeve, Bree Sherry</td>
      </tr>
      <tr> 
        <td>2004</td>
        <td>Melbourne Metropolitan Basketball League</td>
        <td>Premier Division - Men</td>
        <td>Runner-Up</td>

        <td>Whitehorse</td>
        <td>Glenda De Marinis</td>
        <td>Sean Powell, Lang Ip, Jason Kotchoff, Lachlan Strong, Liam Norton, 
          Nicholas Masunda, Jamie Hagan, Ben Dewer, James Fidler</td>
      </tr>
      <tr> 
        <td>2003</td>
        <td>Victorian Basketball League</td>

        <td>Premier</td>
        <td>Runner-Up</td>
        <td>Werribee</td>
        <td>Martin DeLange, Daisy Adams (assistant)</td>
        <td>Martin DeLange, Scott Cuffe, James Hutton, James Pescott, Liam Norton, 
          Matthew Rafton, Anthony Nantes, Lucien Boland, Nick Rintoul, Jason Kotchoff, 
          Matt Dunn</td>
      </tr>

      <tr> 
        <td>2003</td>
        <td>Melbourne Metropolitan Basketball League</td>
        <td>Division Two - Men</td>
        <td>Runner-Up</td>
        <td>Coburg</td>
        <td>Martin DeLange</td>

        <td>Martin DeLange, Jason Kotchoff, James Fidler, Sean Powell, Lang Ip, 
          Lachlan Strong, Matthew Bell</td>
      </tr>
      <tr> 
        <td>2003</td>
        <td>CYMS</td>
        <td>A Grade</td>
        <td>Runner-Up</td>

        <td>Moonee Ponds</td>
        <td>Glenda De Marinis</td>
        <td>Shoane Ip, Kuhn Ip, Peter Betros, Aaron McGovern, Raef Akehurst, Nigel 
          Seear, James Fidler, Justin Turnley</td>
      </tr>
      <tr> 
        <td>2003</td>
        <td>Albury Tournament</td>

        <td>Division One - Men</td>
        <td>Champions</td>
        <td>NSW Select</td>
        <td>Martin DeLange</td>
        <td>Martin DeLange, Scott Cuffe, James Hutton, Dan Tully, Sean Powell, 
          Lang Ip, Jason Kotchoff</td>
      </tr>

      <tr> 
        <td>2002</td>
        <td>Victorian Basketball League</td>
        <td>Premier Division Men</td>
        <td>Runner-Up</td>
        <td>Nunawading</td>
        <td>Tony Holden</td>

        <td>Scott Cuffe, Martin De Lange, James Pescott, James Hutton, Liam Norton, 
          Ross McNeil, Matt Dunn, Anthony Nantes, Matt Rafton, Lach Strong, Dan 
          Tully</td>
      </tr>
      <tr> 
        <td>2002</td>
        <td>Australian University Games</td>
        <td>Men</td>
        <td>Champions</td>

        <td>-</td>
        <td>Tony Holden</td>
        <td>Scott Cuffe, James Pescott, Liam Norton, Matt Dunn, Nigel Seear, Lach 
          Strong, </td>
      </tr>
      <tr> 
        <td>2002</td>
        <td>Australian University Games</td>

        <td>Women</td>
        <td>3rd</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
      </tr>

      <tr> 
        <td>2001</td>
        <td>Australian University Games</td>
        <td>Women</td>
        <td>Champions</td>
        <td>-</td>
        <td>-</td>

        <td>-</td>
      </tr>
      <tr> 
        <td>2001</td>
        <td>Australian University Games</td>
        <td>Men</td>
        <td>Runner-Up</td>

        <td>-</td>
        <td>-</td>
        <td>-</td>
      </tr>
      <tr> 
        <td>2000</td>
        <td>Australian University Games</td>

        <td>Men</td>
        <td>3rd</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
      </tr>

      <tr>
        <td>2001</td>
        <td>CYMS</td>

        <td>AR1 Grade Men</td>
        <td>Runners Up</td>
        <td>-</td>
        <td>Matt Rafton</td>
        <td>Mike Woolrich, Raef Akehurst, Lach Strong, Tommy Sim, Vlade Angelovski, Karl Edwards, Toby Wallace-Crabbe, Mayur</td>
      </tr>

      <tr> 
        <td>2000</td>
        <td>Victorian Basketball League</td>
        <td>Division One - Men</td>
        <td>Runner-Up</td>
        <td>Horsham</td>
        <td>Tony Holden, Marc Howard (assistant)</td>

        <td>Lucien Boland, Mark Boland, Jamie Cemm, Pete Furlong, Anthony Michielin, 
          Anthony Nantes, James Pescott, Matthew Rafton, Nick Rintoul, Stuart 
          Verrier</td>
      </tr>
      <tr> 
        <td>1998</td>
        <td>Australian University Games</td>
        <td>Men</td>
        <td>Champions</td>

        <td>Monash University</td>
        <td>Tony Goodwin, Marc Howard (assistant), Herman Tokatlidis (assistant)</td>
        <td>Lucien Boland, Jamie Cemm, Scott Cuffe, Elliot Dean, Stuart Forsyth, 
          Paul Gregorevic, Nick Rintoul, Ken Santamaria, Liam Santamaria, Tim 
          Sturrock, James Hutton</td>
      </tr>
      <tr> 
        <td>1998</td>
        <td>Melbourne Metropolitan Basketball League</td>

        <td>Premier Division - Men</td>
        <td>Runners-Up</td>
        <td>Blackburn</td>
        <td>Tony Goodwin, Marc Howard (assistant), Herman Tokatlidis (assistant) 
        </td>
        <td>Lucien Boland, Jamie Cemm, Michael Crowe, Elliot Dean, Paul Gregorevic, 
          Nick Rintoul, Ken Santamaria, Stuart Verrier</td>
      </tr>

      <tr> 
        <td>1998</td>
        <td>Melbourne Metropolitan Basketball League</td>
        <td>Premier Division - Women</td>
        <td>Champions</td>
        <td>-</td>
        <td>-</td>

        <td>Emily Cleeve, Tracy Dyt...-</td>
      </tr>
      <tr> 
        <td>1996</td>
        <td>Australian University Games</td>
        <td>Men</td>
        <td>Runner-Up</td>

        <td>Canberra University</td>
        <td>Tony Goodwin, Marc Howard (assistant)</td>
        <td>
    Anthony Michelin, Elliot Dean, Michael Crowe, Luke Gatuso, 
    Scott Cuffe, Mark Boland, James Hutton, Lucien Boland, 
    Daniel Forster, Chris Clarke, Ken Santamaria
  </td>
      </tr>
      <tr> 
        <td>1988</td>

        <td>Australian University Games</td>
        <td>Women</td>
        <td>Champions</td>
        <td>-</td>
        <td>Rob Sweetten, Gillian Payne (team manager) </td>
        <td>Samantha Macleod, Donna Watt, Debbie Kool, Tania Luders, Jo Storer, 
          Narelle Frohling, Sally Bickerton, Lisa Swartz, Rebecca Stockdale, Fiona 
          Bird, Kim Jachno</td>

      </tr>
      <tr> 
        <td>1985</td>
        <td>Australian University Games</td>
        <td>Women</td>
        <td>Champions</td>
        <td>-</td>

        <td>John Campbell, Trevor Smith (team manager)</td>
        <td>Bridget Grounds, Lindy (Spike) Barrett, Anne Cantwell, Kylie O'Brien, 
          Debbie Kool, Tracey Nero, Ellen Maxwell, Gillian Payne, Lisa Swartz, 
          Sally Bickerton</td>
      </tr>
      <tr> 
        <td>1984</td>
        <td>South Pacific Universities Championships</td>
        <td>Men</td>

        <td>Runner-Up</td>
        <td>Monash</td>
        <td>n/a</td>
        <td>Trevor Andrew, Geoff Bowles, Simon Brown-Greaves, John Campbell, Brian 
          Connors, Henry Cooper, Dave Crombie, Dave Davies, Graeme Jane, Tony 
          Lewis</td>
      </tr>
    </tbody>
  </table>
  }
)
  