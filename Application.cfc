<!---
/**
 * Main Application.cfc
 *
 * @FileName: Application.cfc
 * @Original Author: Andrea Veggiani
 * @Created: 09/19/2007
 * $LastChangedDate: $
 * $LastChangedRevision: $
 * $LastChangedBy: $
*/
--->


<cfcomponent name="Application">

	<cfscript>
		this.name 							= "wayd";
		this.db								= 'wayd';
		this.applicationTimeout 			= createTimeSpan(0,2,0,0);
		this.sessionManagement 				= true;
		this.sessionTimeout 				= createTimeSpan(0,0,20,0);
		this.loginstorage					= "session";
		this.charset						= 'utf-8';
		this.locale							= 'it_IT';
		this.mapping						= this.name;
		this.appMapping						= getDirectoryFromPath(getCurrentTemplatePath());
		this.mappings["/#this.name#"]		= getDirectoryFromPath(getCurrentTemplatePath());
		this.customTagPaths 				= getDirectoryFromPath(getCurrentTemplatePath()) & "customtags";
	</cfscript>

	<cffunction name="onApplicationStart" returntype="boolean" output="true">

		<cfscript>
			application.db						= this.db;
			application.mapping					= this.name;
			application.pathmapping				= this.appmapping;
			application.initializedAt			= Now();
			application.userFilesPath			= this.appMapping & '/repository';

			application.mainConfiguration		= CreateObject("component","#this.mapping#.cfc.configuration").init('#ExpandPath("/#this.mapping#/config/config.ini")#');

			application.ResourceBundle	= createObject("component","#this.mapping#.share.external.javaRB.coreJava.javaRB");
			application.lnStrings		= application.ResourceBundle.getResourceBundle('#ExpandPath("/#this.mapping#/languages/language.properties")#',this.locale);

			if (isdefined('application.Configuration.internationalization') and structkeyexists(application.Configuration.internationalization,'locale'))
				this.locale = application.Configuration.internationalization.locale;
			
			application.waydObj 			= createobject('component','#this.mapping#.cfc.wayd');
			application.userObj 			= createobject('component','#this.mapping#.cfc.user');
			application.dbObj 				= createobject('component','#this.mapping#.cfc.db');
			application.dbObj.init();
			
			application.listDirReserved		= 'ajax,cfc,config,css,customtags,database,documentation,gateway,images,include,js,languages,onmissing,pdf,photos,share';
		</cfscript>

		<cfreturn true>
	</cffunction>

	<cffunction name="onApplicationEnd" returntype="boolean" output="false">
		<cfargument name="applicationScope" required="true">
		<cfreturn true>
	</cffunction>

	<cffunction name="onRequestStart" output="false" returntype="boolean">
		<cfargument name="targetPage" type="string" required="yes">

		<cfscript>

			if (isdefined('url.reload'))
				{
					onApplicationStart();
					onSessionStart();
				}

					onApplicationStart();
					onSessionStart();

			request.charset		= this.charset;
			request.db			= this.db;
			request.mapping		= this.mapping;
			request.pathmapping = this.appMapping;
			
			setLocale(this.locale);
		</cfscript>

		<!--- Login --->
		<cflogin>
			<cfif isDefined("cflogin")>
				<cfscript>
					qryUser 			= session.userObj.login(cflogin.name,cflogin.password);
				</cfscript>
				<cfif qryUser.recordcount is not 0>
					<cfset request.loginSuccessful	= true>
					<cfloginuser name="#qryUser.userid#|#qryUser.email#|#cflogin.name#" password="#cflogin.password#" roles="user">
				<cfelse>
					<cfset request.loginSuccessful	= false>
				</cfif>
			</cfif>
		</cflogin>

		<!--- Logout --->
  		<cfif isdefined('url.logout') or isdefined('form.logout')>
			<cflogout>
			<cfscript>
				structclear(session);
			</cfscript>
			<cflocation url="#cgi.script_name#" addtoken="no">
		</cfif>
		
		<cfif arguments.targetPage contains '.cfc' or cgi.cf_template_path contains 'flex2gateway' or arguments.targetPage contains 'makepdfhistory'>
			<cfscript>
				structDelete(variables,"onRequest"); 
				structDelete(this,"onRequest");
			</cfscript>
			<cfsetting showdebugoutput="true">
		</cfif>

		<cfreturn true>
	</cffunction>

	<cffunction name="onRequest" returntype="boolean">
		<cfargument name="targetPage" type="string" required="true">

		<cfinclude template="/#request.mapping#/include/functions.cfm">	

		<cfinclude template="#Arguments.targetPage#" />
		<cfreturn true>
	</cffunction>

	<cffunction name="onRequestEnd" output="true" returntype="boolean">
		<cfargument name="targetPage" type="string" required="true">

		<cfsetting showdebugoutput="false">
		<cfreturn true>
	</cffunction>

	<cffunction name="onSessionStart" output="false" returntype="boolean">
		<cfscript>
			session.lang				= 'it_IT';
			session.userObj 			= createobject('component','#this.mapping#.cfc.user');
		</cfscript>
		<cfreturn true>
	</cffunction>

	<cffunction name="onSessionEnd" output="false" returntype="boolean">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">

		<cflogout>

		<cfreturn true>
	</cffunction>
	
	<cffunction name="onmissingtemplate">

		<cfscript>
			// get real name page to include based on the first folder in the url
			mypage = '#listgetat(cgi.script_name,1,'/')#.cfm';
			// get the url param based on the second folder in the url if present
			if (listlen(cgi.script_name,'/') gt 1)
				url.myparam = listgetat(cgi.script_name,2,'/');
			onRequestStart(mypage);
		</cfscript>
		<cfinclude template="/#request.mapping#/include/top.cfm">
		<cfinclude template="/#request.mapping#/include/functions.cfm">	
		<cfdiv id="content">
			<cfif fileexists(expandpath('/#request.mapping#/onmissing/#mypage#'))>
				<!--- if the mypage exists in the onmissing foldere include it --->
				<cfinclude template="/#request.mapping#/onmissing/#mypage#">
			<cfelse>
				<!--- otherwise it means the mypage contains a username and i've type an http://wayd/username url --->
				<cfset url.username = listgetat(cgi.script_name,1,'/')>
				<cfinclude template="/#request.mapping#/onmissing/user.cfm">
			</cfif>
		</cfdiv>
		<cfinclude template="/#request.mapping#/include/right.cfm">
		<cfinclude template="/#request.mapping#/include/bottom.cfm">
		<cfscript>
			onRequestEnd(mypage);
		</cfscript>

	</cffunction>
	
	<!---
	<cffunction name="onError">
	   <cfargument name="Except" required=true />
	   <cfargument type="String" name = "EventName" required=true />

		<!--- workaround for CFLOCATION BUG --->
		<cfif StructKeyExists(arguments.Except, 'rootCause') AND arguments.Except.rootCause EQ "coldfusion.runtime.AbortException">
			<cfreturn true>
		<cfelseif StructKeyExists(arguments.Except, 'message') AND arguments.Except.message EQ "">
			<cfreturn true>
		<cfelse>
			<cfmail 
				to="#application.mainConfiguration.mailinfo.email#" 
				from="#application.mainConfiguration.mailinfo.from#" 
				subject="Errore" 
				type="html">
				<cfoutput>
					<p>Error Event: #EventName#</p>
					<p>
						Error details:<br/>
						<cfdump var="#except#">
					</p>
					<p>
						Application:<br/>
						<cfdump var="#application#">
					</p>
					<p>
						CGI:<br />
						<cfdump var="#cgi#">
					</p>
					<p>
						FORM:<br />
						<cfdump var="#form#">
					</p>
					<p>
						URL:<br />
						<cfdump var="#url#">
					</p>
				</cfoutput>
			</cfmail>
		</cfif>

		<cfreturn true>
	</cffunction>
	--->

	<!--- Get system path separator character --->
	<cffunction name="getPathSeparator" access="private" returntype="string">
	   <!--- Init variables --->
	   <cfset var jifObj="">
	   <!--- Need java.io.File class --->
	   <cfobject type="java" class="java.io.File" name="jifObj">
	   <!--- Return seperator --->
	   <cfreturn jifObj.separator>
	</cffunction>

</cfcomponent>