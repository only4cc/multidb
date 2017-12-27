set nocount on;

use DBA
;

select 	[dd hh:mm:ss.mss],
		login_name,
		program_name,
		host_name 
from WhoIsActive
;