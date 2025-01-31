Feature: display list of movies sorted by different criteria
 
  As an avid moviegoer
  So that I can quickly browse movies based on my preferences
  I want to see movies sorted by title or release date

Background: movies have been added to database
  
  Given the following movies have been added to RottenPotatoes: 
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
  When I check the following ratings: PG,G,R,PG-13
  And I click submit

Scenario: sort movies alphabetically
When I follow "Movie Title"
Then I should see "Amelie" before "When Harry Met Sally"

Scenario: sort movies in increasing order of release date
When I follow "Release Date"
#with this I am checking the string for the release data as YYYY-MM-DD HH:MM:SS UTC
Then I should see "1981-06-12 00:00:00 UTC" before "2004-11-05 00:00:00 UTC"
