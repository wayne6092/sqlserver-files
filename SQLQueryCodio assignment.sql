USE football;
GO
/*select gameid as [gameid]
  , gamedate as [gameDate]
  , gameTime as [gameTime]
from game;
*/

/*select teamname
from team
order by teamname;
*/
/*select distinct healthcon
from player
order by healthcon;
*/

/*select gameid as [Game ID]
	, gamedate as [Game Date]
	, locationID as [LocationID]
from game
Order By gameDate desc, LocationID;
*/

select PersonID as [Person ID]
	, Fee as [Current Fee]
	, Fee * 0.2 as [Increase]
	, Fee * 1.2 as [New Fee]
from playerrec
Order By Fee desc;

GO