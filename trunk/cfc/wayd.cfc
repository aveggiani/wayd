<cfcomponent>
	<cffunction name="update" access="public" returntype="void">
		<cfargument name="userid" type="numeric" required="yes">
		<cfargument name="wayd" type="string" required="yes">

		<cfset var myquery = "">
		<cfquery name="myquery" datasource="#application.db#">
			insert into wayds
				(
					userid,
					wayd,
					created
				)
			values
				(
					#arguments.userid#,
					'#arguments.wayd#',
					#dateformat(now(),'yyyymmdd')##timeformat(now(),'HHmmss')#
				)
		</cfquery>
		<cfscript>
			application.userObj.adviceSubscribers(arguments.userid,arguments.wayd);
		</cfscript>

	</cffunction>

	<cffunction name="get" access="public" returntype="query">
		<cfargument name="userid" type="numeric" required="no">
		<cfargument name="waydid" type="numeric" required="no">

		<cfset var myquery = "">
		<cfquery name="myquery" datasource="#application.db#">
			select wayds.waydid,wayds.wayd,wayds.created,users.photo,users.username from wayds,users
				where
					1=1
				<cfif isdefined('arguments.userid')>
					and users.userid = #arguments.userid#
				</cfif>
				<cfif isdefined('arguments.waydid')>
					and wayds.waydid = #arguments.waydid#
				</cfif>
				and wayds.userid = users.userid
			order by created desc
		</cfquery>
		
		<cfreturn myquery>
	</cffunction>

	<cffunction name="getAllIndexOnly" access="private" returntype="query">
		<cfargument name="userid" type="numeric" required="no">

		<cfset var myquery = "">
		<cfquery name="myquery" datasource="#application.db#">
			select WAYDID from wayds
				<cfif isdefined('arguments.userid')>
					where userid = #arguments.userid#
				</cfif>
			order by created desc
		</cfquery>
		
		<cfreturn myquery>
	</cffunction>

	<cffunction name="getStringTime" access="public" returntype="string">
		<cfargument name="numericaDate" type="numeric" required="no">

		<cfscript>
			var myresult = '';
			var myDate = createdatetime(left(arguments.numericaDate,4),mid(arguments.numericaDate,5,2),mid(arguments.numericaDate,7,2),mid(arguments.numericaDate,9,2),mid(arguments.numericaDate,11,2),right(arguments.numericaDate,2));
			if (datediff('s',mydate,now()) lte 5)
				myresult = "timeless5seconds";
			else if (datediff('s',mydate,now()) lte 30)
				myresult = "timeless30seconds";
			else if (datediff('n',mydate,now()) lte 1)
				myresult = "timeless1minute";
			else if (datediff('n',mydate,now()) lte 59)
				myresult = "timeless30minute,#datediff('n',mydate,now())#";
			else if (datediff('h',mydate,now()) lte 24)
				myresult = "timelesshour,#datediff('h',mydate,now())#";
			else
				myresult = "timelessdate,#dateformat(mydate,'dd/mm/yyyy')# #timeformat(mydate,'HH:mm')#";
		</cfscript>
		
		<cfreturn myresult>
	</cffunction>

	<cffunction name="getCount" access="public" returntype="numeric">
		<cfargument name="userid" type="numeric" required="no">

		<cfset var myquery = "">
		<cfquery name="myquery" datasource="#application.db#">
			select count(*) as howmany from wayds
				<cfif isdefined('arguments.userid')>
					where userid = #arguments.userid#
				</cfif>
		</cfquery>
		
		<cfreturn myquery.howmany>
	</cffunction>

	<cffunction name="getFull" access="public" returntype="query">
		<cfargument name="page" 	type="numeric" required="yes" default="1">
		<cfargument name="pagesize" type="numeric" required="yes" default="8">
		<cfargument name="userid" type="numeric" required="no">

		<cfscript>
			var myqueryapp	= '';
			var myqueryapp2 = '';
			var myquery 	= '';

			if (isdefined('arguments.userid'))
				myqueryapp  = getAllIndexOnly(userid=arguments.userid);
			else
				myqueryapp  = getAllIndexOnly();

			rowStart 		= arguments.pagesize * (arguments.page-1) + 1;
			rowEnd			= rowStart + arguments.pagesize - 1;
			
			rowCountCurrent = arguments.page * arguments.pageSize;
			myquery = querynew('waydid,userid,photo,username,wayd,created');
		</cfscript>

		<cfloop query="myqueryapp" startrow="#rowstart#" endrow="#rowend#" >
			<cfscript>
				myqueryapp2 		= get(waydid = myqueryapp.waydid);
				queryaddrow(myquery,1);
				querysetcell(myquery,'waydid',myqueryapp2.waydid);
				querysetcell(myquery,'photo',myqueryapp2.photo);
				querysetcell(myquery,'username',myqueryapp2.username);
				querysetcell(myquery,'wayd',myqueryapp2.wayd);
				querysetcell(myquery,'created',myqueryapp2.created);
			</cfscript>
		</cfloop>
		
		<cfreturn myquery>
	</cffunction>
	
</cfcomponent>