Feature: display list of movies sorted by different criteria
 
  As an avid moviegoer
  So that I can quickly browse movies based on my preferences
  I want to see movies sorted by title or release date

Background: movies have been added to database
  
  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And I am on the RottenPotatoes home page

Scenario: sort movies alphabetically
  Given I check the following ratings: G, R, PG-13, PG, NC-17
  And I press "ratings_submit"
  When I follow "title_header"
  Then I should see "Chocolat" before "Raiders of the Lost Ark"

Scenario: sort movies in increasing order of release date
  Given I check the following ratings: G, R, PG-13, PG, NC-17
  And I press "ratings_submit"
  When I follow "release_date_header"
  Then I should see "Raiders of the Lost Ark" before "Chocolat"
