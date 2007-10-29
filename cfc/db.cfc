<cfcomponent displayname="Database Component" hint="Component for DB Initialization and management">

	<cffunction name="init" access="public" output="yes" returntype="void">
	
		<cfdbinfo datasource="#application.db#" name="dbinfo" type="tables" >
		
		<cfscript>
			this.countries = getCountries();
		
			if (not listfind(valuelist(dbinfo.table_name),'WAYDS'))
				{
					dropTables();
					createTables();
				}
		</cfscript>
		
	</cffunction>

	<cffunction name="createTables" access="private" returntype="void">
		<cftransaction>
			<cfquery name="myquery" datasource="#application.db#">
				CREATE TABLE WAYDS
					(
						WAYDID 			INT NOT NULL GENERATED ALWAYS AS IDENTITY( START WITH 1,INCREMENT BY 1),
						USERID 			INT NOT NULL,
						WAYD 			VARCHAR(140),
						CREATED			BIGINT NOT NULL,
						PRIMARY KEY (WAYDID)
					)
			</cfquery>
			<cfquery name="myquery" datasource="#application.db#">
				CREATE TABLE SUBSCRIPTIONS
					(
						USERID 			INT NOT NULL,
						SUBSCRIBED		INT NOT NULL
					)
			</cfquery>
			<cfquery name="myquery" datasource="#application.db#">
				CREATE TABLE USERS
					(
						USERID 			INT NOT NULL GENERATED ALWAYS AS IDENTITY( START WITH 1,INCREMENT BY 1),
						USERNAME 		VARCHAR(10),
						PASSWORD 		VARCHAR(10),
						EMAIL 			VARCHAR(80),
						TIMEZONE 		VARCHAR(100),
						SITEURL 		VARCHAR(100),
						IM 				VARCHAR(50),
						BIO 			VARCHAR(2000),
						PHOTO 			VARCHAR(2000),
						NOTIFICATIONS	VARCHAR(1),
						STATUS			VARCHAR(1),
						UUID			VARCHAR(35),
						COUNTRY			VARCHAR(2),
						CREATED			BIGINT NOT NULL,
						PRIMARY KEY (USERID)
					)
			</cfquery>
			<cfquery name="myquery" datasource="#application.db#">
				CREATE TABLE LOGS
					(
						LOGID 			INT NOT NULL GENERATED ALWAYS AS IDENTITY( START WITH 1,INCREMENT BY 1),
						IP 				VARCHAR(15) NOT NULL,
						USERID 			INT,
						TYPE 			VARCHAR(10),
						WDDXPACKET 		VARCHAR(4000),
						PRIMARY KEY (LOGID)
					)
			</cfquery>
		</cftransaction>
	</cffunction>

	<cffunction name="dropTables" access="private" returntype="void">
		<cftransaction>
			<cftry>
				<cfquery name="myquery" datasource="#application.db#">
					DROP TABLE WAYDS
				</cfquery>
				<cfcatch>
				</cfcatch>
			</cftry>
			<cftry>
				<cfquery name="myquery" datasource="#application.db#">
					DROP TABLE USERS
				</cfquery>
				<cfcatch>
				</cfcatch>
			</cftry>
			<cftry>
				<cfquery name="myquery" datasource="#application.db#">
					DROP TABLE SUBSCRIPTIONS
				</cfquery>
				<cfcatch>
				</cfcatch>
			</cftry>
			<cftry>
				<cfquery name="myquery" datasource="#application.db#">
					DROP TABLE LOGS
				</cfquery>
				<cfcatch>
				</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>
	
	<cffunction name="getCountries" access="private" returntype="query">
	
		<cfscript>
			var myfile 	= FileOpen("#application.pathmapping#/database/countrycodes.txt");
			var myquery = querynew('code,country'); 
			var line	= '';
		</cfscript>

		<cfloop condition="Not FileIsEOF(myfile)">
			<cfscript>
				line = FileReadLine(myfile);
				queryaddrow(myquery);
				querysetcell(myquery,'code',listgetat(line,1,' '));
				querysetcell(myquery,'country',listrest(line,' '));
			</cfscript>
		</cfloop>
		<cfreturn myquery>
	
	</cffunction>

</cfcomponent>