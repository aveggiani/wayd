<cfcomponent displayname="chefai" hint="Process events from the chefai gateway">

	<cfinclude template="/#request.mapping#/include/functions.cfm">	

	<cffunction name="onIncomingMessage" output="no">
		<cfargument name="CFEvent" type="struct" required="yes">
		
		<cfscript>
			var message			= CFEvent.data.message;
			var originatorID	= CFEvent.originatorID;
			var retValue		= structNew();
			retValue.BuddyID	= originatorID;
			waydcommand			= ucase(trim(listgetat(message,1,' ')));
			
		</cfscript>

		<cfswitch expression="#waydcommand#">
			<cfcase value="HELP">
				<cfscript>
					returnMessage	= getString('imReplyHelp');
				</cfscript>
			</cfcase>
			<cfdefaultcase>
				<cfscript>
					myuser = application.userObj.getUserFromIm(retValue.BuddyID);
					if (myuser.recordcount gt 0)
						{
							application.waydObj.update(myuser.userid,message);
						}
					returnMessage = getString('imreplywayd');
				</cfscript>
			</cfdefaultcase>
		</cfswitch>

		<cfset retValue.Message = returnMessage>
		
		<!--- send the return message back --->
		<cfreturn retValue>
	</cffunction>
	
	<cffunction name="onAddBuddyRequest">
		<cfargument name="CFEvent" type="struct" required="true">
		<cfset var retValue = structNew()>
	
		<cfset retValue.Command="accept">
		<cfset retValue.BuddyID=CFEvent.data.sender>
		<cfset retValue.Reason="Welcome!">
	
	  <cfreturn retValue>
	</cffunction>
	
	<cffunction name="onAddBuddyResponse">
		<cfargument name="CFEvent" type="struct" required="YES">
	</cffunction>
	
	<cffunction name="onBuddyStatus">
		<cfargument name="CFEvent" type="struct" required="YES">
	</cffunction>
	
	<cffunction name="onIMServerMessage">
		<cfargument name="CFEvent" type="struct" required="YES">
	</cffunction>
	
	<cffunction name="onAdminMessage">
		<cfargument name="CFEvent" type="struct" required="YES">
	</cffunction>

</cfcomponent>