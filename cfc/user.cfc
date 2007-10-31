<cfcomponent>
	<cfinclude template="/#application.mapping#/include/functions.cfm">	

	<cffunction name="update" access="public" returntype="string">
		<cfargument name="userid" type="numeric" required="yes">
		<cfargument name="myStruct" type="struct" required="yes">

		<cfscript>
			var myquery 	= '';
		</cfscript>
		
		<cfif isdefined('arguments.mystruct.deletephoto') or trim(form.photo) is not ''>
			<cfscript>
				myuser = get(arguments.userid);
			</cfscript>
			<cftry>
				<cfif fileexists('#request.pathmapping#/photos/#myuser.photo#')>
					<cffile action="delete" file="#request.pathmapping#/photos/#myuser.photo#">
				</cfif>
				<cfcatch>
				</cfcatch>
			</cftry>
		</cfif>
		<cfif trim(form.photo) is not ''>
			<cftry>
				<cflock name="uplodadPhoto" timeout="1000">
					<cffile accept="image/*" action="upload" destination="/#application.pathmapping#/photos/" filefield="form.photo" nameconflict="makeunique">
					<cfimage action="read" name="uploadedimage" source="/#application.pathmapping#/photos/#cffile.serverfile#">
					<cfimage name="uploadedimage" action="resize" height="96" overwrite="true" source="/#application.pathmapping#/photos/#cffile.serverfile#" destination="/#application.pathmapping#/photos/96/#cffile.serverfile#" width="96">
					<cfimage name="uploadedimage" action="resize" height="24" overwrite="true" source="/#application.pathmapping#/photos/#cffile.serverfile#" destination="/#application.pathmapping#/photos/24/#cffile.serverfile#" width="24">
					<cfimage name="uploadedimage" action="resize" height="48" overwrite="true" source="/#application.pathmapping#/photos/#cffile.serverfile#" destination="/#application.pathmapping#/photos/#cffile.serverfile#" width="48">
					<cfset arguments.mystruct.photo = cffile.serverfile>
				</cflock>
				<cfcatch>
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfquery name="myquery" datasource="#application.db#">
			update users
				set
					email 	= '#arguments.mystruct.email#',
					siteurl = '#arguments.mystruct.siteurl#',
					bio 	= '#arguments.mystruct.bio#',
					im 		= '#arguments.mystruct.im#',
					country = '#arguments.mystruct.country#'
					<cfif trim(arguments.mystruct.password) is not ''>
						,password 	= '#arguments.mystruct.password#'
					</cfif>
					<cfif isdefined('arguments.mystruct.deletephoto')>
						,photo=''
					<cfelse>
						<cfif trim(form.photo) is not ''>
							,photo 	= '#arguments.mystruct.photo#'
						</cfif>
					</cfif>
			where
				userid = #arguments.userid#
				
		</cfquery>
		
	</cffunction>
	
	<cffunction name="preregister" access="public" returntype="string">
		<cfargument name="myStruct" type="struct" required="yes">

		<cfscript>
			var myquery 	= '';
			var myresult 	= '';
			var myuuid		= createuuid();
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			insert into users
				(
					USERNAME,
					PASSWORD,
					EMAIL,
					STATUS,
					UUID,
					CREATED
				)
				values
				(
					'#arguments.mystruct.username#',
					'#arguments.mystruct.password#',
					'#arguments.mystruct.email#',
					'D',
					'#myuuid#',
					#dateformat(now(),'yyyymmdd')##timeformat(now(),'HHmmss')#
				)
		</cfquery>
		
		<cfmail to="#arguments.mystruct.email#" from="#application.mainconfiguration.mailinfo.from#" subject="Richiesta conferma registrazione CheFai.it" type="html">
			Per confermare la tua registrazione a CheFai.it clicca qui:
			<br />
			<a href="http://#cgi.SERVER_NAME#/confirm/index.cfm?uuid=#myuuid#">http://#cgi.SERVER_NAME#/confirm.cfm?uuid=#myuuid#</a>
		</cfmail>

	</cffunction>
	
	<cffunction name="getUserFromIm" access="public" returntype="query">
		<cfargument name="im" type="string" required="no">

		<cfscript>
			var myquery 	= '';
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select * from users 
				where im = '#arguments.im#'
		</cfquery>

		<cfreturn myquery>
	</cffunction>

	<cffunction name="getUserFromUsername" access="public" returntype="query">
		<cfargument name="username" type="string" required="no">

		<cfscript>
			var myquery 	= '';
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select * from users 
				where username = '#arguments.username#'
		</cfquery>

		<cfreturn myquery>
	</cffunction>

	<cffunction name="forgotpwd" access="public" returntype="void">
		<cfargument name="email" type="string" required="no">

		<cfscript>
			var myquery 	= '';
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select * from users 
				where email = '#arguments.email#'
		</cfquery>
		<cfif myquery.recordcount gt 0>		
			<cfmail to="#arguments.email#" from="#application.mainConfiguration.mailinfo.email#" subject="#getstring('forgotpwdmailsubject')#" type="html">
				#getstring('forgotpwdmailmessage')#
				
				#myquery.email#
			</cfmail>
		</cfif>
	</cffunction>

	<cffunction name="delete" access="public" returntype="void">
		<cfargument name="userid" type="numeric" required="no">

		<cfscript>
			var myquery 	= '';
		</cfscript>

		<cftransaction>
			<cfquery name="myquery" datasource="#application.db#">
				delete from users 
					where userid = #arguments.userid#
			</cfquery>
			<cfquery name="myquery" datasource="#application.db#">
				delete from wayds 
					where userid = #arguments.userid#
			</cfquery>
			<cfquery name="myquery" datasource="#application.db#">
				delete from subscriptions 
					where userid = #arguments.userid#
			</cfquery>
			<cfquery name="myquery" datasource="#application.db#">
				delete from subscriptions 
					where subscribed = #arguments.userid#
			</cfquery>
		</cftransaction>
	</cffunction>

	<cffunction name="get" access="public" returntype="query">
		<cfargument name="userid" type="numeric" required="no">
		<cfargument name="search" type="string" required="no">

		<cfscript>
			var myquery 	= '';
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select * from users 
				where 1 = 1
				<cfif isdefined('arguments.userid')>
					and userid = #arguments.userid#
				</cfif>
				<cfif isdefined('arguments.search')>
					and (
							username like '%#arguments.search#%'
							or
							bio like '%#arguments.search#%'
							or
							siteurl like '%#arguments.search#%'
						)
				</cfif>
		</cfquery>

		<cfreturn myquery>
	</cffunction>

	<cffunction name="login" access="public" returntype="query">
		<cfargument name="username" type="string" required="yes">
		<cfargument name="password" type="string" required="yes">

		<cfscript>
			var myquery 	= '';
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select * from users where username = '#arguments.username#' and password = '#arguments.password#' and status = 'A'
		</cfquery>

		<cfreturn myquery>
	</cffunction>

	<cffunction name="confirm" access="public" returntype="boolean">
		<cfargument name="myuuid" type="UUID" required="yes">

		<cfscript>
			var myquery 	= '';
			var myresult 	= false;
		</cfscript>

		<cftransaction>
			<cfquery name="myquery" datasource="#application.db#">
				select userid from users where uuid = '#arguments.myuuid#' and status = 'D'
			</cfquery>
			<cfif myquery.recordcount is 1>
				<cfquery name="myquery" datasource="#application.db#">
					update users set status = 'A' where userid = #myquery.userid#
				</cfquery>
				<cfset myresult = true>
			</cfif>
		</cftransaction>

		<cfreturn myresult>
	</cffunction>

	<cffunction name="checkavailability" access="remote" returntype="string">
		<cfargument name="username" required="yes" type="string">

		<cfscript>
			var myquery = '';
			var myresult = 'usernamenotavailable';
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select count(*) as howmany from users where username = '#arguments.username#'
		</cfquery>
		
		<cfscript>
			if (myquery.howmany == 0)
				if ( not listfind(application.listDirReserved,arguments.username))
					myresult = 'usernameavailable';
		</cfscript>
		
		<cfreturn getstring(myresult)>
	</cffunction>

	<cffunction name="getFollows" access="public" returntype="query">
		<cfargument name="userid"  type="numeric" required="yes">

		<cfscript>
			var myquery 		= '';
		</cfscript>
		<cfquery name="myquery" datasource="#application.db#">
			select * from users where userid in (select subscribed from subscriptions where userid = #arguments.userid#)
		</cfquery>
		<cfreturn myquery>
		
	</cffunction>

	<cffunction name="getFollowers" access="public" returntype="query">
		<cfargument name="userid"  type="numeric" required="yes">

		<cfscript>
			var myquery 		= '';
		</cfscript>
		<cfquery name="myquery" datasource="#application.db#">
			select * from users where userid in (select userid from subscriptions where subscribed = #arguments.userid#)
		</cfquery>
		<cfreturn myquery>
		
	</cffunction>

	<cffunction name="follow" access="public" returntype="void">
		<cfargument name="userid"  type="numeric" required="yes">
		<cfargument name="follow"  type="numeric" required="yes">
		<cfargument name="value"  type="boolean" required="yes">

		<cfscript>
			var myquery 		= '';
		</cfscript>

		<cfif arguments.value>
			<cftransaction>
				<cfquery name="myquery" datasource="#application.db#">
					select userid from subscriptions where userid = #arguments.userid# and subscribed = #arguments.follow#
				</cfquery>
				<cfif myquery.recordcount is 0>
					<cfquery name="myquery" datasource="#application.db#">
						insert into subscriptions values (#arguments.userid#,#arguments.follow#)
					</cfquery>
				</cfif>
			</cftransaction>
		<cfelse>
			<cfquery name="myquery" datasource="#application.db#">
				delete from subscriptions where userid = #arguments.userid# and subscribed = #arguments.follow#
			</cfquery>
		</cfif>
		
	</cffunction>

	<cffunction name="imfollowing" access="public" returntype="boolean">
		<cfargument name="userid"  type="numeric" required="yes">
		<cfargument name="subscribed"  type="numeric" required="yes">

		<cfscript>
			var myquery 		= '';
			var result			= true;
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select subscribed from subscriptions where subscribed = #arguments.subscribed# and userid = #arguments.userid#
		</cfquery>
		<cfif myquery.recordcount is 0>
			<cfset result = false>
		</cfif>
		
		<cfreturn result>
	</cffunction>

	<cffunction name="getMySubscribers" access="public" returntype="query">
		<cfargument name="userid"  type="numeric" required="yes">

		<cfscript>
			var myquery 		= '';
		</cfscript>

		<cfquery name="myquery" datasource="#application.db#">
			select users.userid,im,username,country,siteurl,bio,photo from USERS
				where users.userid in (select subscribed from subscriptions where userid = #arguments.userid#)
		</cfquery>
		
		<cfreturn myquery>
	</cffunction>

	<cffunction name="adviceSubscribers" access="public" returntype="void">
		<cfargument name="userid"  type="numeric" required="yes">
		<cfargument name="message" type="string" required="yes">

		<cfscript>
			var myquery 		= '';
			var mystruct		= structnew();
			var mysender		= application.userObj.get(arguments.userid).username;
		</cfscript>
		<cfquery name="myquery" datasource="#application.db#">
			select im from USERS where userid in (select userid from subscriptions where subscribed = #arguments.userid#)	
		</cfquery>
		<cfscript>
			mystruct.buddyID	= myquery.im;
			mystruct.message	= '(#mysender#): ' & arguments.message;	
		</cfscript>

		<!---
			<cfset success = StructNew()>
			<cfset success.Destination = "ColdFusionGateway">
			<cfset success.body = mystruct.message>
			<cfset ret = SendGatewayMessage("flexmessaging", success)>
		--->

		<cftry>
			<cfloop query="myquery">
				<cfscript>
					SendGatewayMessage(application.mainConfiguration.xmppinfo.gatewayinstance, mystruct);
				</cfscript>
			</cfloop>
			<cfcatch>
			</cfcatch>
		</cftry>
		
	</cffunction>

</cfcomponent>